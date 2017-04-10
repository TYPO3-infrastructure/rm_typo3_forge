class AddProjectTopbarCustomizations < ActiveRecord::Migration
  def self.up
    unless column_exists?(:projects, :quicklinks)
      add_column :projects, :quicklinks, :text
    end
  end

  def self.down
    remove_column :projects, :quicklinks
  end
end
