class AddSortingField < ActiveRecord::Migration
  def self.up
    unless column_exists?(:projects, :sorting)
      add_column :projects, :sorting, :integer, :default => 0
    end
  end

  def self.down
    remove_column :projects, :sorting
  end
end
