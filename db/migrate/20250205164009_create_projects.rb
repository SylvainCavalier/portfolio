class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :github_url
      t.string :image_url
      t.string :tech_stack

      t.timestamps
    end
  end
end
