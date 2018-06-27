class CreateWorkflowSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :workflow_steps do |t|
      t.integer :document_id
      t.string :email
      t.boolean :read_only

      t.timestamps
    end
  end
end
