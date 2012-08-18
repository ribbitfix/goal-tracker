class ReportsController < ApplicationController
	def new
		@report = Report.new(:user_id => params[:user_id])
		@statuses = @report.build_statuses
	end

	def create
		@user = User.find(params[:user_id])

		if @report = @user.reports.create(params[:report])
			redirect_to user_path(@user)
		else
			render :action => :new
		end
	end
	
end