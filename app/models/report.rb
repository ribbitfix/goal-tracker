class Report < ActiveRecord::Base
  attr_accessible :goal_id, :goal_met, :report_date
  belongs_to :goal
end
