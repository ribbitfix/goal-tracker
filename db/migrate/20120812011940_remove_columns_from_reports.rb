class RemoveColumnsFromReports < ActiveRecord::Migration
  def up
    remove_column :reports, :goal_met
        remove_column :reports, :goal_id
      end

  def down
    add_column :reports, :goal_id, :integer
    add_column :reports, :goal_met, :boolean
  end
end
