more_goals = [{:goal_name => "meditate", :times_per_week => 7},
	{:goal_name => "be in bed by 11", :times_per_week => 5},
	{:goal_name => "exercise", :times_per_week => 3}]

Goal.send(:attr_accessible, :goal_name, :times_per_week)

more_goals.each do |goal|
	Goal.create!(goal)
end