class ReportsController < ApplicationController
	def new
		@report = Report.new(:user_id => params[:user_id])
		@statuses = @report.build_statuses
	end

	def create
		@report = Report.create!(params[:report])
		@statuses = @report.statuses.create!(params[:status])
	end
end