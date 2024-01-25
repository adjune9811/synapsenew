resource_group = "variable-rg"
location = "East US"
storage_account_name = "addsdemosynapsestorage"
data_lake_gen2_filesystem = "filesystem"
azurerm_synapse_workspace = "tf-synapse-workspace"
azurerm_synapse_spark_pool = "tfSparkPool00"

synapse_sql_pools = {
  pool1 = {
    synapse_workspace_id = "synapse"
    sku_name             = "DW100c"
    create_mode          = "Default"
    storage_account_type = "GRS"
  },
  pool2 = {
    synapse_workspace_id = "synapse"
    sku_name             = "DW200c"
    create_mode          = "Default"
    storage_account_type = "GRS"
  }
}
