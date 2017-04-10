class AddTopbarBackgroundcolor < ActiveRecord::Migration
  def self.up
    unless column_exists?(:projects, :topbarbackgroundcolor)
      add_column :projects, :topbarbackgroundcolor, :string
    end
  end

  def self.down
    remove_column :projects, :topbarbackgroundcolor
  end
end
