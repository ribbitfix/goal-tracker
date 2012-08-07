class GoalsController < ApplicationController
	def index
		@goals = Goal.all
	end

	def show
		id = params[:id]
		@goal = Goal.find(id)
	end
end