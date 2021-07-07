# Terraform Gaming4Life

This repository's purpose is to provide an IaC to deploy the architecture for the Gaming4Life project, which main
purpose is to create an environment for their next big video game called "Clash of Shadow Go".

# Documentation

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.24 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.46.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =2.46.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >=3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service.g4lifeas](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/app_service) | resource |
| [azurerm_app_service_plan.g4lifesp](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/app_service_plan) | resource |
| [azurerm_cosmosdb_account.g4lifedb](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_sql_database.g4lifedbsql](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/cosmosdb_sql_database) | resource |
| [azurerm_frontdoor.g4lifefd](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/frontdoor) | resource |
| [azurerm_hdinsight_hadoop_cluster.g4lifehdic](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/hdinsight_hadoop_cluster) | resource |
| [azurerm_resource_group.g4liferg](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/resource_group) | resource |
| [azurerm_storage_account.g4lifesa](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/storage_account) | resource |
| [azurerm_storage_container.g4lifesc](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/storage_container) | resource |
| [azurerm_traffic_manager_endpoint.g4lifetme](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/traffic_manager_endpoint) | resource |
| [azurerm_traffic_manager_profile.g4lifetmp](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/traffic_manager_profile) | resource |
| [random_id.server](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_integer.ri](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_G4L_HDI_GW_PASSWORD"></a> [G4L\_HDI\_GW\_PASSWORD](#input\_G4L\_HDI\_GW\_PASSWORD) | n/a | `string` | n/a | yes |
| <a name="input_G4L_HDI_GW_USERNAME"></a> [G4L\_HDI\_GW\_USERNAME](#input\_G4L\_HDI\_GW\_USERNAME) | n/a | `string` | n/a | yes |
| <a name="input_G4L_HDI_R_HN_PASSWORD"></a> [G4L\_HDI\_R\_HN\_PASSWORD](#input\_G4L\_HDI\_R\_HN\_PASSWORD) | n/a | `string` | n/a | yes |
| <a name="input_G4L_HDI_R_HN_USERNAME"></a> [G4L\_HDI\_R\_HN\_USERNAME](#input\_G4L\_HDI\_R\_HN\_USERNAME) | n/a | `string` | n/a | yes |
| <a name="input_G4L_HDI_R_WN_PASSWORD"></a> [G4L\_HDI\_R\_WN\_PASSWORD](#input\_G4L\_HDI\_R\_WN\_PASSWORD) | n/a | `string` | n/a | yes |
| <a name="input_G4L_HDI_R_WN_USERNAME"></a> [G4L\_HDI\_R\_WN\_USERNAME](#input\_G4L\_HDI\_R\_WN\_USERNAME) | n/a | `string` | n/a | yes |
| <a name="input_G4L_HDI_R_ZN_PASSWORD"></a> [G4L\_HDI\_R\_ZN\_PASSWORD](#input\_G4L\_HDI\_R\_ZN\_PASSWORD) | n/a | `string` | n/a | yes |
| <a name="input_G4L_HDI_R_ZN_USERNAME"></a> [G4L\_HDI\_R\_ZN\_USERNAME](#input\_G4L\_HDI\_R\_ZN\_USERNAME) | n/a | `string` | n/a | yes |
| <a name="input_failover_location"></a> [failover\_location](#input\_failover\_location) | Azure location | `string` | `"North Europe"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | `"West Europe"` | no |

## Outputs

No outputs.
