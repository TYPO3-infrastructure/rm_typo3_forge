class IncreaseNameValueSizeOnVersions < ActiveRecord::Migration
  def change
    change_column :versions, :name, :string, limit: 255
  end
end
