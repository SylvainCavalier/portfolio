class AddLanguageToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :language, :string, default: 'english'
  end
end
