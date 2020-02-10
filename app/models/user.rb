class User < ApplicationRecord

  ## Associations
  has_many :managed_projects, class_name: 'Project', foreign_key: :manager_id
  has_many :project_users
  has_many :projects, through: :project_users
end
