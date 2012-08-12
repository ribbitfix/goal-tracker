require 'date'

class Report < ActiveRecord::Base
  attr_accessible :user_id :report_date
  belongs_to :user

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
