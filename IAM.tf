resource "azurerm_role_assignment" "blob-data" {
  principal_id ="a84161e8-486c-46c0-8d3f-3a848248cf65"  # The principal ID of the user, service principal, or security group
  role_definition_name = "Storage Blob Data Contributor"  # The name of the RBAC role you want to assign
  scope = azurerm_storage_account.synapse-storage.id  # The ID of the storage account
}


resource "azurerm_role_assignment" "owner-synapse-workspace" {
  principal_id        = "a84161e8-486c-46c0-8d3f-3a848248cf65"  # The principal ID of the user, service principal, or security group
  role_definition_name = "Owner"  # Use an appropriate role like "Synapse Contributor"

  scope = azurerm_synapse_workspace.synapse.id  # The ID of the Synapse Workspace

}

