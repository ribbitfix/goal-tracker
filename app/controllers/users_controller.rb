class UsersController < ApplicationController

	def index
		@users = User.order(:user_name)
	end

	def show
		@user = User.find(params[:id])
		@goals = @user.goals # this doesn't work: .where("goals.active == true")
	end

end