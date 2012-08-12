class Goal < ActiveRecord::Base
  attr_accessible :goal_name, :times_per_week, :state
  has_many :reports
end
