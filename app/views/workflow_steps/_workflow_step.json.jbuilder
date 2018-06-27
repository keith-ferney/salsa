json.extract! workflow_step, :id, :document_id, :email, :read_only, :created_at, :updated_at
json.url workflow_step_url(workflow_step, format: :json)
