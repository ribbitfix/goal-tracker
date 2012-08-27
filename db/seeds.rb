# users = [{:user_name => "foo"}, {:user_name => "bar"}]

# goals = [{:goal_name => "some goal", :times_per_week => 7, :state => true, :user_id => 5},
# 	{:goal_name => "some other goal", :times_per_week => 5, :state => true, :user_id => 5},
# 	{:goal_name => "another goal", :times_per_week => 3, :state => true, :user_id => 6},
# 	{:goal_name => "a goal", :times_per_week => 4, :state => true, :user_id => 6}]

# # Goal.send(:attr_accessible, :goal_name, :times_per_week, :state, :user_id)  # is this line is necessary?

# users.each do |user|
# 	User.create!(user)
# end

# goals.each do |goal|
#  	Goal.create!(goal)
# end
