class Project < ApplicationRecord

  ## Associations
  belongs_to :manager, class_name: "User", foreign_key: :manager_id, optional: true
  has_many :project_users
  has_many :users, through: :project_users

  ## Validations
  validates :name, presence: true, length: { minimum: 2 }
end
