resource "azurerm_storage_account" "synapse-storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"

 depends_on = [azurerm_resource_group.rg ]

}


resource "azurerm_storage_data_lake_gen2_filesystem" "filesystem" {
  name               = var.data_lake_gen2_filesystem
  storage_account_id = azurerm_storage_account.synapse-storage.id
  depends_on = [azurerm_resource_group.rg,
  azurerm_storage_account.synapse-storage ]
}



resource "azurerm_synapse_workspace" "synapse" {
  name                                 = var.azurerm_synapse_workspace
  resource_group_name                  = var.resource_group
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.filesystem.id
  sql_administrator_login              = "ajay"
  sql_administrator_login_password     = "Azure@9811962362"

 depends_on = [azurerm_resource_group.rg,
  azurerm_storage_account.synapse-storage,
  azurerm_storage_data_lake_gen2_filesystem.filesystem ]


  identity {
    type = "SystemAssigned"
  }

}



resource "azurerm_synapse_firewall_rule" "firewallrule" {
  name                 = "AllowAll"
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "255.255.255.255"

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_storage_account.synapse-storage,
    azurerm_synapse_workspace.synapse
  ]
}

/*
resource "azurerm_synapse_sql_pool" "sqlpool" {
  name                 = var.azurerm_synapse_sql_pool
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  sku_name             = "DW100c"
  create_mode          = "Default"
  storage_account_type = "GRS"

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_storage_account.synapse-storage,
    azurerm_synapse_workspace.synapse
  ]
}

*/
resource "azurerm_synapse_spark_pool" "synapseSparkPool001" {
  name                 = var.azurerm_synapse_spark_pool
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  node_size_family     = "MemoryOptimized"
  node_size            = "Small"
  // cache_size           = 100
  auto_scale {
    max_node_count = 10
    min_node_count = 3
  }

  auto_pause {
    delay_in_minutes = 15
  }



  depends_on = [
    azurerm_resource_group.rg,
    azurerm_storage_account.synapse-storage,
    azurerm_synapse_workspace.synapse
  ]

}



resource "azurerm_synapse_sql_pool" "sqlpool" {
  for_each = var.synapse_sql_pools

  name                 = each.key
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  sku_name             = each.value["sku_name"]
  create_mode          = each.value["create_mode"]
  storage_account_type = each.value["storage_account_type"]

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_storage_account.synapse-storage,
    azurerm_synapse_workspace.synapse
  ]
}
