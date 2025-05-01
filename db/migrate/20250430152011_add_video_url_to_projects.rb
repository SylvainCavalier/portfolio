class AddVideoUrlToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :video_url, :string
  end
end
