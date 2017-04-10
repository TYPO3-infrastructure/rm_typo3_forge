class AddTopbarHeaderimage < ActiveRecord::Migration
  def self.up
    unless column_exists?(:projects, :topbarheaderimage)
      add_column :projects, :topbarheaderimage, :string
    end
  end

  def self.down
    remove_column :projects, :topbarheaderimage
  end
end
