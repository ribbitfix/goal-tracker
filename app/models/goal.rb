class Goal < ActiveRecord::Base
  attr_accessible :goal_name, :times_per_week
  has_many :reports
end
