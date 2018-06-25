class AddEnableWorkflowsToOrganization < ActiveRecord::Migration[5.1]
  def change
    change_table :organizations do |t|
      t.boolean :enable_workflows
    end
  end
end
