class Status < ActiveRecord::Base
  attr_accessible :goal_id, :report_id, :status
  belongs_to :goal
  belongs_to :report

  def goal_name # This gets used in the report form
  	goal.goal_name
  end
end
