Goal Tracker
============
A simple goal tracking app, inspired by [750 Words](http://750words.com/).

Process Notes
-------------
### 8/2/12
(at SEPoCoNi)
- Created app: rails new goaltracker -T (-T leaves out Test::Unit - using Rspec instead)
- Edited Gemfile to include Haml and the interactive debugger; ran bundle install to get them (and their dependencies)
- Tried rails server and it didn't work because of gem issues - removed debugger and the server works. WHY IS THIS?
- Came up with schema for Goal and DailyReport
- Learned about generating models and migrations here: http://guides.rubyonrails.org/migrations.html
- Created Goal model
- NEXT: figure out how to do one-to-many relationships and create DailyReport model

### 8/3
- Learned about Active Record associations here: http://guides.rubyonrails.org/association_basics.html
- Created Report model, like this: "rails generate model Report report_date:date goal_met:boolean goal_id:integer"
- Added "has_many :reports" to Goal class and "belongs_to :goal" to Report class
- Ran rake db:migrate, which created the actual tables in the DB and the schema.rb file
- Added "resources :reports" to routes.rb. (Not sure yet what to do with the "root :to => redirect(path)" line.)
- Created git repo, but first went into .gitignore file and commented out the sqlite3 line, since I actually want to use it. (I HOPE THAT'S RIGHT?)
- NEXT: Write some model code! (see SaaSclass textbook chapter 4.3)

### 8/4
Learning about model methods. Some stuff that might be useful:
- Goal.create!(:goal_name => "be awesome", :times_per_week => 7) - this both creates and saves the object
	- create! - if anything goes wrong, an exception is raised - useful in the console
	- create - returns nil if something goes wrong - better in actual app code?
- g = Goal.new(same args) - this should be followed by g.save!
- Report.all - returns a collection of all Report objects
- find:
	- Goal.find(3) - returns goal object with id 3; raises exception if key not found
	- Goal.find_by_id(3) - returns nil if not found
	- Report.find_by_report_date("2012-08-04") - returns a single object
	- find_all_by_attr returns an Enumerable
- current_week = Report.where("report_date >= :this_sunday and report_date <= :this_saturday", :this_sunday => current_sunday(), :this_saturday => current_saturday() ) - returns an Enumerable

TODO: Create helper methods to determine the start date and end date of the current week. Maybe something like:
```ruby
require 'date'
def current_sunday
	today = Date.today
	day_of_week = today.wday  # wday returns the day of week (0-6, Sunday is zero).
	sunday = today - day_of_week
end
```
Learned about working with dates here:
- http://ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html
- http://stackoverflow.com/questions/5171102/ruby-date-subtraction-e-g-90-days-ago

Looking at my model code. The "rails generate model" command gave me an attr_accessible line, not attr_accessor. Learned about attr_accessible here: 
- http://stackoverflow.com/questions/2652907/what-is-difference-between-attr-accessibleattributes-attr-protectedattrib/2652919#2652919
- http://stackoverflow.com/questions/4700785/using-attr-accessor-and-attr-accessible-on-the-same-field

(In Rails, getters and setters are inherited from ActiveRecord, and attr_accessor is only used for attrs to be used in views/models but not saved to the DB.)

Created GoalsController index action and view - a mock-up of the goals summary page - and seeded the DB so it would have something to display. It works!

Started working on the logic to display the current week's data. I'm putting it in the Report model - not sure if that's the right place for it. 

NEXT:
- write current_saturday helper method in Report model
- figure out how to get current week's data into index view 
- "show" action/view: single goal history page

### 8/5
Wrote current_saturday method. 
- It works in irb, but when I try to run it from the file in rails console, it raises NoMethodError.
- Here's why: I was trying to call it as a class method, but wrote it as an instance method. Looked up the syntax for class methods and read this: http://railstips.org/blog/archives/2009/05/11/class-and-instance-methods-in-ruby/
- Added "self." in front of the method name. It works now.
Got current week's data into index view.
- Added a current_week method call to the view (Should probably figure out how to do it from the controller instead?)
- Realized that current_week was returning entire Report objects, when what I actually want is just the goal_met values. Fixed that.

Created a very basic "show" action and view, and linked to it from the index view.

NEXT:
- elaborate on show view
- make "new" view

### 8/6 
(at Collective Agency)

Don recommends fullcalendar.js: http://arshaw.com/fullcalendar/ (looks good, but may be overkill for this project?)

Created ReportsController, "new" action and view.

Learned about form helpers here: http://guides.rubyonrails.org/form_helpers.html
- Generic or "barebones" helpers end with "_tag", e.g. form_tag, label_tag, text_field_tag
- Model object helpers don't: form_for, label, text_field
- To create a single form where the user submits reports for all their goals, it looks like I need to use form_tag, because form_for is only for a single instance.
- Radio buttons are created thusly:

```ruby
radio_button_tag(:nameofbuttonset, "value")
label_tag(:nameofbuttonset_value, "label text")
```
Learned about date pickers here: http://guides.rubyonrails.org/form_helpers.html#using-date-and-time-form-helpers
- barebones helper: select_date 
- model object helper: date_select - use this if the date is a model attr to be saved to the DB

NEXT: 
- finish Report "new" view / "create" action
- go back to "show" view.

### 8/7
(at jury duty)
- Wrote ReportsController "create" action
- Tried submitting the form. It creates a single new Report object with report_date filled in but the other attrs nil.
- In the ReportsController "create" method, put "Report.create!" inside a Goals.all.each block. Now the form creates 3 new Report objects with dates but nothing else.
- Tried using radio_button instead of radio_button_tag, to associate the buttons with the model, but that led to only 1 of the 6 buttons being selectable, because it made them all into 1 set instead of 3 yes-no sets.
- Learned about the fields_for helper here: 
	- http://stackoverflow.com/questions/5553484/radio-button-group-for-nested-form-in-rails
	- http://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-fields_for

Maybe I need to implement a User model to make this work? Since that's ultimately the parent model? Something like:
```ruby
form_for :user do |f|
	f.fields_for :goal do |g_f|
		g_f.fields_for :report do |r_f|
```
More on radio buttons in nested forms: 
- http://stackoverflow.com/questions/1577631/rails-form-with-multiple-nested-models-causes-issues-with-radio-groups
- http://stackoverflow.com/questions/5090820/rails-radio-button-selection-for-nested-objects

### 8/8
(at the Lucky Lab)

Changed the radio_button_tag arguments like so: ("report[#{name}]", "true")
- which generated this HTML: ```<input id="report_meditate_true" type="radio" value="true" name="report[meditate]">```
- and led to this error message: "ActiveModel::MassAssignmentSecurity::Error in ReportsController#create Can't mass-assign protected attributes: meditate, be in bed by 11, exercise"

Chuck says: if you need nested forms, it may be an indication that your data model needs rethinking. So, this:
- User
- Goal
	- name
	- state (active or archived)
- Report
	- user_id
	- date
	- :build_statuses (class or instance method?)
- Status
	- report_id
	- goal_id
	- status

Also learned about scaffolding:
- Used "rails g scaffold status report_id:integer goal_id:integer state:string" to create a whole bunch of files:
```
invoke  active_record
      create    db/migrate/20120809024102_create_statuses.rb
      create    app/models/status.rb
       route  resources :statuses
      invoke  scaffold_controller
      create    app/controllers/statuses_controller.rb
      invoke    erb
      create      app/views/statuses
      create      app/views/statuses/index.html.erb
      create      app/views/statuses/edit.html.erb
      create      app/views/statuses/show.html.erb
      create      app/views/statuses/new.html.erb
      create      app/views/statuses/_form.html.erb
      invoke    helper
      create      app/helpers/statuses_helper.rb
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/statuses.js.coffee
      invoke    scss
      create      app/assets/stylesheets/statuses.css.scss
      invoke  scss
      create    app/assets/stylesheets/scaffolds.css.scss
```
- Did rake db:migrate
- Went into Gemfile and uncommented therubyracer; ran bundle to install it.
- Quit and restarted the server, then went to http://localhost:3000/statuses
- To get rid of the scaffold files: rails destroy scaffold status

NEXT: git commit and start anew.


QUESTIONS
- How to install debugger without breaking the server?

TODO
- Figure out how to add value constraints to DB columns in Rails (eg. Goal times_per_week - valid values are 1 thru 7)
- Figure out time zone stuff - looks like the default is GMT. Will want to use the user's local time instead.
- Check out http://www.lucidtracker.com/

NOTES FOR FUTURE VERSIONS
- Will want to allow for inactive goals to remain in the user's history - deleting a goal should not remove the data already collected. (addressed this on 8/8 with Goal state attr)
