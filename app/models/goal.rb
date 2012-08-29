require "date"

class Goal < ActiveRecord::Base
  attr_accessible :goal_name, :times_per_week, :active, :user_id
  
  belongs_to :user
  has_many :statuses

  validates :goal_name, :presence => true
  validates :times_per_week, :presence => true, :inclusion => {:in => 1..7}
  validates :active, :presence => true

  after_initialize :set_active

  def set_active
  	self.active = true
  end

  # TODO: rewrite this stuff. As is, it's just passing an array of status booleans to the view,
  # disassociated from their dates, so they're not displaying correctly. 

  def current_week_statuses
    bools = []
    current_week_reports.each do |report|
      statuses = report.statuses
      statuses.each do |status|
        if status.goal_id == self.id
          bools << status.status
        end
      end
    end
    bools
  end

  private

  def current_sunday
    today = Date.today
    day_of_week = today.wday  # wday returns the day of week (0-6, Sunday is zero).
    sunday = today - day_of_week
  end

  def current_saturday
    today = Date.today        # hmm,
    day_of_week = today.wday  # this stuff's redundant.
    diff = 6 - day_of_week
    saturday = today + diff
  end

  def current_week_reports
    reports = Report.where("report_date >= :this_sunday 
      and report_date <= :this_saturday", 
      :this_sunday => current_sunday(), 
      :this_saturday => current_saturday() )
  end

end