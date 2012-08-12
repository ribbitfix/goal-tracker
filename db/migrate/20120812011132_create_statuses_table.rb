class CreateStatusesTable < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.boolean :status
      t.integer :goal_id
      t.integer :report_id

      t.timestamps
    end
  end
end
