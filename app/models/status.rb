class Status < ActiveRecord::Base
  attr_accessible :goal_id, :report_id, :status
  belongs_to :goal
  belongs_to :report
end
