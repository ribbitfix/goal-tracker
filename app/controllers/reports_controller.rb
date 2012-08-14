class ReportsController < ApplicationController
	def new
		@report = Report.new(user_id => params[:id])
		@statuses = @report.build_statuses
	end

	def create
		
	end
end