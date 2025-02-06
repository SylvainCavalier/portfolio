class CreateSections < ActiveRecord::Migration[7.1]
  def change
    create_table :sections do |t|
      t.string :title
      t.text :content
      t.integer :order

      t.timestamps
    end
  end
end
