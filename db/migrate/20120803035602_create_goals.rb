class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :goal_name
      t.integer :times_per_week

      t.timestamps
    end
  end
end
