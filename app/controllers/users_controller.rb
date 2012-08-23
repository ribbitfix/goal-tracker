class UsersController < ApplicationController

	def index
		@users = User.order(:user_name)
	end

	def show
		@user = User.find(params[:id])
		@goals = @user.goals # this doesn't work: .where("goals.active == true")
	end

	def new
		@user = User.new
	end

	def create
		@user = User.create!(params[:user])
		redirect_to user_path(@user)
	end

end