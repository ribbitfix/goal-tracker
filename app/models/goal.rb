class Goal < ActiveRecord::Base
  attr_accessible :goal_name, :times_per_week, :active, :user_id
  
  belongs_to :user
  has_many :statuses

  validates :goal_name, :presence => true
  validates :times_per_week, :presence => true, :inclusion => {:in => 1..7}
  validates :active, :presence => true

end
