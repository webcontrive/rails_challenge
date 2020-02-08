class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :manager_id
      t.timestamps
    end

    add_index :projects, :manager_id
  end
end
