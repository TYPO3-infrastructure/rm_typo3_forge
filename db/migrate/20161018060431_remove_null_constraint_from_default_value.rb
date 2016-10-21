class RemoveNullConstraintFromDefaultValue < ActiveRecord::Migration
  def change
    change_column :custom_fields, :default_value, :text, :null => true
  end
end
