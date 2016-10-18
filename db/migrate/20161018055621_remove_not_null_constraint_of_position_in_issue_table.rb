class RemoveNotNullConstraintOfPositionInIssueTable < ActiveRecord::Migration
  def change
    change_column :issues, :position, :integer, :null => true
  end
end
