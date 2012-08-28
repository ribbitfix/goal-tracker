class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@goals = @user.goals # this doesn't work: .where("goals.active == true")
	end

	def new
		@user = User.new
	end

	def create
		if @user = User.create(params[:user])
			redirect_to user_path(@user)
		else
			render "new"
		end
	end

end