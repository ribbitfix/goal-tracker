class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :report_id
      t.integer :goal_id
      t.string :state

      t.timestamps
    end
  end
end
