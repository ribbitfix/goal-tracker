class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :goals, :state, :active
  end
end
