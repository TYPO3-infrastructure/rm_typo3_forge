class RemoveNotNullConstraintOfPositionInIssueTable < ActiveRecord::Migration
  def change
    if column_exists?(:issues, :position)
      change_column :issues, :position, :integer, :null => true
    end
  end
end
