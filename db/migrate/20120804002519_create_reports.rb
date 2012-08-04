class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.date :report_date
      t.boolean :goal_met
      t.integer :goal_id

      t.timestamps
    end
  end
end
