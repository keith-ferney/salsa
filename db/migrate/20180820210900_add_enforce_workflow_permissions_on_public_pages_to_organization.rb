class AddEnforceWorkflowPermissionsOnPublicPagesToOrganization < ActiveRecord::Migration[5.1]
  def change
    change_table :organizations do |t|
      t.boolean :enforce_workflow_permissions_on_document_view, default: false
    end
  end
end
