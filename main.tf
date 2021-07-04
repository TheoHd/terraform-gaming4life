provider "azurerm" {
  features {}
}

resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}

resource "azurerm_resource_group" "g4liferg"{
  name = "g4life-resources"
  location = var.location
}

resource "azurerm_traffic_manager_profile" "g4lifetmp" {
  name                = random_id.server.hex
  resource_group_name = azurerm_resource_group.g4liferg.name

  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = random_id.server.hex
    ttl           = 100
  }

  monitor_config {
    protocol                     = "http"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_traffic_manager_endpoint" "g4lifetme" {
  name                = random_id.server.hex
  resource_group_name = azurerm_resource_group.g4liferg.name
  profile_name        = azurerm_traffic_manager_profile.g4lifetmp.name
  target              = "terraform.io"
  type                = "externalEndpoints"
  weight              = 100
}

resource "azurerm_frontdoor" "g4lifefd"{
  name                                         = "g4life-FrontDoor"
  location                                     = "Global"
  resource_group_name                          = azurerm_resource_group.g4liferg.name
  enforce_backend_pools_certificate_name_check = false

  routing_rule {
    name               = "g4lifeRoutingRule1"
    accepted_protocols = [
      # "Http", 
      "Https"
    ]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["g4lifeFrontendEndpoint1"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "g4lifeBackendBing"
    }
  }

  backend_pool_load_balancing {
    name = "g4lifeLoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "g4lifeHealthProbeSetting1"
  }

  backend_pool {
    name = "g4lifeBackendBing"
    backend {
      host_header = "www.google.com"
      address     = "www.google.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "g4lifeLoadBalancingSettings1"
    health_probe_name   = "g4lifeHealthProbeSetting1"
  }

  frontend_endpoint {
    name      = "g4lifeFrontendEndpoint1"
    host_name = "g4life-FrontDoor.azurefd.net"
  }
}

resource "azurerm_app_service_plan" "g4lifesp" {
  name                = "g4life-appserviceplan"
  location            = azurerm_resource_group.g4liferg.location
  resource_group_name = azurerm_resource_group.g4liferg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}
resource "azurerm_app_service" "g4lifeas" {
  name                = "g4life-app-service"
  location            = azurerm_resource_group.g4liferg.location
  resource_group_name = azurerm_resource_group.g4liferg.name
  app_service_plan_id = azurerm_app_service_plan.g4lifesp.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_cosmosdb_account" "g4lifedb" {
  name                = "tfex-cosmos-g4lifedb-${random_integer.ri.result}"
  location            = azurerm_resource_group.g4liferg.location
  resource_group_name = azurerm_resource_group.g4liferg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = var.failover_location
    failover_priority = 1
  }

  geo_location {
    location          = azurerm_resource_group.g4liferg.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "g4lifedbsql" {
  name                = "tfex-cosmos-mongo-db"
  resource_group_name = azurerm_cosmosdb_account.g4lifedb.resource_group_name
  account_name        = azurerm_cosmosdb_account.g4lifedb.name
  throughput          = 400
}

resource "azurerm_storage_account" "g4lifesa" {
  name                     = "g4lifestoraccount"
  resource_group_name      = azurerm_resource_group.g4liferg.name
  location                 = azurerm_resource_group.g4liferg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "g4lifesc" {
  name                  = "vhds"
  storage_account_name  = azurerm_storage_account.g4lifesa.name
  container_access_type = "private"
}

resource "azurerm_hdinsight_hadoop_cluster" "g4lifehdic" {
  name                = "g4life-hdicluster"
  resource_group_name = azurerm_resource_group.g4liferg.name
  location            = azurerm_resource_group.g4liferg.location
  cluster_version     = "3.6"
  tier                = "Standard"

  component_version {
    hadoop = "2.7"
  }

  gateway {
    enabled  = true
    username = var.G4L_HDI_GW_USERNAME
    password = var.G4L_HDI_GW_PASSWORD
  }

  storage_account {
    storage_container_id = azurerm_storage_container.g4lifesc.id
    storage_account_key  = azurerm_storage_account.g4lifesa.primary_access_key
    is_default           = true
  }

  roles {
    head_node {
      vm_size  = "Standard_D3_V2"
      username = var.G4L_HDI_R_HN_USERNAME
      password = var.G4L_HDI_R_HN_PASSWORD
    }

    worker_node {
      vm_size               = "Standard_D4_V2"
      username              = var.G4L_HDI_R_WN_USERNAME
      password              = var.G4L_HDI_R_WN_PASSWORD
      target_instance_count = 3
    }

    zookeeper_node {
      vm_size  = "Standard_D3_V2"
      username = var.G4L_HDI_R_ZN_USERNAME
      password = var.G4L_HDI_R_ZN_PASSWORD
    }
  }
}

# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }

# resource "aws_instance" "ubuntu" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.instance_type

#   tags = {
#     Name = var.instance_name
#   }
# }