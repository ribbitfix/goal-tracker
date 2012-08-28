class GoalsController < ApplicationController
	
	def new
		@user = User.find(params[:user_id])
		@goal = Goal.new(:user_id => params[:user_id])
	end

	def create
		@user = User.find(params[:user_id])
		if @goal = @user.goals.create(params[:goal])
			flash[:notice] = "Your goal was successfully created."
			redirect_to user_path(@user)
		else
			render "new"
		end
	end

	def edit
		@goal = Goal.find(params[:id])
	end

	# this needs fixing
	def update
		@goal = Goal.find(params[:id])
		if @goal.update_attributes(params[:goal])
			flash[:notice] = "Your goal was updated."
			redirect_to user_path(@goal.user)
		elsif @goal.update_column(:active, params[:goal][:active])
			flash[:notice] = "Your goal was updated."
			redirect_to user_path(@goal.user)	
		else
			render "edit"
		end
	end
	
end