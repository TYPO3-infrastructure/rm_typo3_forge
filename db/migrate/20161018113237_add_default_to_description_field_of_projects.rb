class AddDefaultToDescriptionFieldOfProjects < ActiveRecord::Migration
  def change
    change_column :projects, :description, :text, null: true
  end
end
