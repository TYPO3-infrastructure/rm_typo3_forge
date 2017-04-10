class AddTopbarTextcolor < ActiveRecord::Migration
  def self.up
    unless column_exists?(:projects, :topbartextcolor)
      add_column :projects, :topbartextcolor, :string
    end
  end

  def self.down
    remove_column :projects, :topbartextcolor
  end
end
