class ProjectUser < ApplicationRecord

  ## Associations
  belongs_to :user
  belongs_to :project

  ## Validations
  validates :project_id, presence: true
  validates :user_id, presence: true, uniqueness: { scope: :project_id }
end
