class WorkflowStep < ApplicationRecord
  validate :not_end_step_and_next_step
  validates :slug, presence: true
  validates :slug, uniqueness: { scope: :organization_id, message: "is already in use for this organization" }, allow_nil: false
  validates :next_workflow_step_id, uniqueness: { scope: :organization_id, message: "is already in use for this organization" }, allow_nil: true
  belongs_to :organization
  belongs_to :parent, :class_name => 'WorkflowStep'
  has_one :children, :class_name => 'WorkflowStep', :foreign_key => 'parent_id'

  def self.workflows organization_id
    workflows = []
    wf_steps = WorkflowStep.where(start_step: true, organization_id: organization_id)
    wf_steps.each do |wf_step|
      wf_done = false
      workflow = []
      workflow.push wf_step
      next_wf_step_id = wf_step.next_workflow_step_id
      wf_done = true if next_wf_step_id == nil
      while wf_done != true do
        wfs = WorkflowStep.find(next_wf_step_id)
        workflow.push wfs
        next_wf_step_id = wfs.next_workflow_step_id
        if wfs.end_step == true || wfs.next_workflow_step_id == nil
          wf_done = true
        end
      end
      workflows.push workflow
    end
      return workflows
  end

  def not_end_step_and_next_step
    h = @attributes.to_h
    if h.fetch("next_workflow_step_id") !=nil && h.fetch("end_step") == true
      errors.add(:next_workflow_step_id, "cant have a next workflow step id if end_step is selected")
      errors.add(:end_step, 'cant have end step selected if there is a next workflow step id')

      return
    end

  end
end