class CreateProjectUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :project_users do |t|
      t.integer :project_id, index: true
      t.integer :user_id, index: true
      t.timestamps
    end
  end
end
