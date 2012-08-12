class AddStateToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :state, :boolean
  end
end
