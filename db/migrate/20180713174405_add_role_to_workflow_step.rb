class AddRoleToWorkflowStep < ActiveRecord::Migration[5.1]
  def change
    change_table :workflow_steps do |t|
      t.string :role
      t.integer :role_organization_id
    end
  end
end
