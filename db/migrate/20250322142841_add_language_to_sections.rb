class AddLanguageToSections < ActiveRecord::Migration[7.1]
  def change
    add_column :sections, :language, :string, default: 'english'
  end
end
