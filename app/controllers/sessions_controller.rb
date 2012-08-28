class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:email])
		if user and user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to user_path(user)
		else
			flash[:warning] = "Invalid email or password."
			render "new"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "You are logged out."
	end

end
