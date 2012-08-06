more_goals = [{:goal_name => "meditate", :times_per_week => 7},
	{:goal_name => "be in bed by 11", :times_per_week => 5},
	{:goal_name => "exercise", :times_per_week => 3}]

Goal.send(:attr_accessible, :goal_name, :times_per_week)  # is this line is necessary?

# more_goals.each do |goal|
# 	Goal.create!(goal)
# end

reports = [{:goal_id => 2, :goal_met => true, :report_date => "2012-08-05"},
	{:goal_id => 3, :goal_met => true, :report_date => "2012-08-05"},
	{:goal_id => 4, :goal_met => true, :report_date => "2012-08-05"}
]

Report.send(:attr_accessible, :goal_id, :goal_met, :report_date)

reports.each do |report|
	Report.create!(report)
end