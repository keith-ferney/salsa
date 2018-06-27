class Organization < ApplicationRecord
  acts_as_nested_set

  has_many :documents
  has_many :components

  default_scope { order('lft, rgt') }
  validates :slug, presence: true
  validates :slug, exclusion: { in: %w(status), message: "%{value} is reserved." }
  validates :name, presence: true

  def self.import_documents(file, org)
    CSV.foreach(file.path, headers: true) do |row |
      doc = Document.find_or_create_by(name: row[0], organization_id: org.id)
      row.delete(0)
      row.each do |r|
        if r[0].include? ":ro"
          ds = WorkflowStep.find_or_create_by(document_id: doc.id, email: r[1], read_only: true)
        else
          ds = WorkflowStep.find_or_create_by(document_id: doc.id, email: r[1], read_only: false)
        end
      end
    end
  end
end
