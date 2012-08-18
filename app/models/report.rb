# require 'date'

class Report < ActiveRecord::Base
  attr_accessible :user_id, :report_date, :statuses_attributes
  belongs_to :user
  has_many :statuses

  accepts_nested_attributes_for :statuses, :allow_destroy => true

  def build_statuses
    goals = self.user.goals
    goals.each do |goal|
      statuses.build(:goal_id => goal.id)
    end
    statuses
  end

  # # Some or all of this code is probably going away.
  # def self.current_week(goal_key)
  #   reports = Report.where("report_date >= :this_sunday 
  # 		and report_date <= :this_saturday 
  # 		and goal_id == :goal_id", 
  # 		:this_sunday => current_sunday(), 
  # 		:this_saturday => current_saturday(),
  # 		:goal_id => goal_key)
  #   bools = []
  #   reports.each { |report| bools << report.goal_met }
  #   bools
  # end

  # def self.current_sunday
  #   today = Date.today
  #   day_of_week = today.wday  # wday returns the day of week (0-6, Sunday is zero).
  #   sunday = today - day_of_week
  # end

  # def self.current_saturday
  #   today = Date.today        # hmm,
  #   day_of_week = today.wday  # this stuff's redundant.
  #   diff = 6 - day_of_week
  #   saturday = today + diff
  # end
  
end
