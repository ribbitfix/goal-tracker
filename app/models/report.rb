require 'date'

class Report < ActiveRecord::Base
  attr_accessible :goal_id, :goal_met, :report_date
  belongs_to :goal

  def current_week(goal_key)
  	Report.where("report_date >= :this_sunday 
  		and report_date <= :this_saturday 
  		and goal_id == :goal_id", 
  		:this_sunday => current_sunday(), 
  		:this_saturday => current_saturday(),
  		:goal_id => goal_key)
  end

	def current_sunday
		today = Date.today
		day_of_week = today.wday  # wday returns the day of week (0-6, Sunday is zero).
		sunday = today - day_of_week
	end

	def current_saturday
		#write this
	end
end
