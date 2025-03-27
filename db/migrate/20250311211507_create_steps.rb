class CreateSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :steps do |t|
      t.string :name
      t.string :date
      t.string :location
      t.text :description
      t.string :language

      t.timestamps
    end
  end
end
