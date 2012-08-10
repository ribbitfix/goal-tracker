class ReportsController < ApplicationController
	def new
		@goals = Goal.all
	end

	def create
		puts params
		Goal.all.each { |goal| Report.create!(params[:report]) }
		redirect_to goals_path
	end
end