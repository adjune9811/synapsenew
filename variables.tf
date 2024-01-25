variable "resource_group" {
  type     = string
  description = "This is use for resource group"

}

variable "location" {
  type     = string
  description = "This is use for location"
}


variable "storage_account_name" {
  type     = string
  description = "This is use for Storage account name "
}

variable "data_lake_gen2_filesystem" {
  type     = string
  description = "This is use for file system name"
  }

  variable "azurerm_synapse_workspace" {
  type     = string
  description = "This is use for azurerm_synapse_workspace"
  }

/*
   variable "azurerm_synapse_sql_pool" {
  type     = string
  description = "This is use for azurerm_synapse_sql_pool"
  }

*/

     variable "azurerm_synapse_spark_pool" {
  type     = string
  description = "This is use for azurerm_synapse_spark_pool"
  }

  variable "synapse_sql_pools" {
  type = map(object({
    synapse_workspace_id = string
    sku_name             = string
    create_mode          = string
    storage_account_type = string
  }))
  description = "Map of Synapse SQL pools configurations"
}
