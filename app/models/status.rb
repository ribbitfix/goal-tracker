class Status < ActiveRecord::Base
  attr_accessible :goal_id, :report_id, :state
end
