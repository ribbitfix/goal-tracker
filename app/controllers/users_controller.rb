class UsersController < ApplicationController

	def index
		@users = User.order(:user_name)
	end

	def show
		@user = User.find(params[:id])
	end

end