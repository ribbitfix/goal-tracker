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
	- DB migration
	- status model, routes, controller, views, helper
	- JS and CSS assets
- Did rake db:migrate
- Went into Gemfile and uncommented therubyracer; ran bundle to install it. (This embeds the V8 JS interpreter into Ruby.)
- Quit and restarted the server, then went to http://localhost:3000/statuses to see the magic in action.
- To get rid of the scaffold files: rails destroy scaffold status

NEXT: git commit and start anew.

### 8/10
(at Jeff's house)

Jeff recommends git flow, a plugin command line tool for git. Hotfix is its killer feature - allows you to fix a bug in one branch and apply it to all branches.

Jeff says: display code should not be in the model. You could put it in the controller, but that's not great either. This is a common failure of MVC. A couple other options:
- Model wrapper - queries the DB (this is maybe like helpers or decorators in rails?)
- ViewModel - pass in objects (presenter? See Igal's meetup notes here: https://groups.google.com/d/msg/pdxruby/pylgB7-KMwI/dwmsE5wXMmgJ)

In either case, you'd have, for example, a CalendarReport and a GraphReport wrapper or viewmodel.

Form view: instead of radio buttons, you could have a single button for each goal, linked to hidden radio buttons with JS. OR! Better yet, don't even have a separate report screen - submit reports from the summary view, using AJAX.

### 8/11
Poked around the scaffold files for a while, then removed them using "rails destroy scaffold status". Although the status-specific files and routes are gone, the code to create the statuses table is still in the schema, even after running rake db:migrate. (The scaffolds stylesheet is still there too.)

Created User model: 
- rails g model User user_name:string
- added "has_many :goals" and "has_many :reports" to model
Created Status model:
- rails g model Status goal_id:integer status:boolean report_id:integer
- added "belongs_to :goal" and "belongs_to :report"

Tried to run the migrations and they didn't work because the old statuses table still exists. Wrote a migration to drop it, then realized that wasn't going to work unless I deleted the previous migration. Did that, then realized what I should have done: rather than deleting the old status table, I could have just updated it by removing the state:string column and adding a status:boolean column. Duh.

Added state attr to Goal: 
- rails g migration AddStateToGoals state:boolean
- added :state to list of attrs in model

Created new statuses table; updated Report model and table to reflect the new data model.

NEXT: 
- The code in the Report model no longer makes sense - rework or get rid of it.
- Build some basic views, play around with fullcalendar.js?

### 8/12
Learned about git add options:
- -A - all
- . - new and modified
- -u - modified and deleted

Added routes for users and statuses, and made root redirect to users.

Oops: forgot to add user_id to Goal yesterday. Created and ran the migration, and updated the model.

Created simple controller methods and views for User index and show.

Learned about validations and added some to the Goal model.

Realized I still don't know how to go about creating the Report form.

NEXT:
- Add validations to other models
- Figure out the report form. Maybe these will help:
	- http://blog.dominicsayers.com/2011/08/24/howto-create-a-simple-parent-child-form-in-rails-3-1/
	- http://stackoverflow.com/questions/3499208/ruby-on-rails-building-a-child-with-default-values-when-its-parent-is-created

### 8/13
Learned about working with parent-child relationships:
- If ```u = User.find 1```, ```u.goals``` will return all Goal objects where ```user_id == 1```
- To create new child objects: ```u.goals.create!(:goal_name => "do stuff", :times_per_week => 7, :state => true)```
- See also http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#M001316

Changed name of Goal "state" attr to "active" using this method:
```ruby
def change
	rename_column :table_name, :old_column, :new_column
end
```

Wrote build_statuses method in Report model. In the console, did this:
```ruby
r=Report.new
 => #<Report id: nil, report_date: nil, created_at: nil, updated_at: nil, user_id: nil> 
r.statuses
 => []
```
Realized build_statuses requires a user_id. So, tried this:
```ruby
s=Report.new(:user_id => 5)
 => #<Report id: nil, report_date: nil, created_at: nil, updated_at: nil, user_id: 5> 
s.statuses
 => [] 
```
So maybe before_create is only called when create (or save) is called? Yes: tried Report.create, and it called build_statuses. But: still got an empty statuses array.

Try calling build_statuses from ReportController "new" method instead?

In the User "show" view, can I pass a params[:id] arg to new_report_view?

Maybe look at these again:
- http://stackoverflow.com/questions/2110857/creating-a-set-number-of-child-objects-from-a-parents-form
- http://stackoverflow.com/questions/783584/ruby-on-rails-how-do-i-use-the-active-record-build-method-in-a-belongs-to-rel

### 8/14
Learned about nested resources here: 
- http://guides.rubyonrails.org/routing.html#nested-resources
- http://weblog.jamisbuck.org/2007/2/5/nesting-resources

An experiment:
- Changed my routes: nested reports in users.
- In my User "show" view, changed "Submit a report" path to new_user_report_path(@user)
- When I click "Submit a report", there's a user_id in the params, hooray!

So build_statuses is returning Goal objects, not Status objects. Fixed that. 

Created new form. Getting the same security error as before. NEXT: Reproduce error and figure out how to fix it.

### 8/15
Searched for info on accepts_nested_attribute_for; read these:
- http://archives.ryandaigle.com/articles/2009/2/1/what-s-new-in-edge-rails-nested-attributes
- http://www.manas.com.ar/spalladino/2010/03/03/handling-children-with-accepts_nested_attributes_for-in-rails/
- http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html

Yesterday I tried using ```form_for @report``` but it didn't do the routing properly - reports_path no longer exists; it's now user_reports_path. Today it occurred to me that I maybe I could just specify the correct path, and indeed I can. Read about it here: http://stackoverflow.com/questions/2718059/nested-resources-in-namespace-form-for

So. I'm back to creating a nested form, even though the point of Chuck's data model suggestions - if I understood correctly - was to avoid having to deal with nested forms. So apparently I'm doing something wrong here? But I don't know what else to try, so I'm just going to proceed. FILDI.

Tried the form_for / fields_for approach but no statuses were created. Not sure why. Going back to yesterday's version of the form.

What's showing up in my params right now is this: "statuses"=>{"some goal"=>"true", "some other goal"=>"false", "do stuff"=>"true"}. What the Status model actually wants to see is "status" => "true", but then I'm back to the problem of having one big set of radio buttons instead of multiple yes/no pairs. There's gotta be a way to make this work, but at this point I'm inclined to give up on radio buttons and try something else. Namely checkboxes.

Maybe I need to use hidden_field_tag to pass the other params for statuses?

OK, the checkboxes form is successfully creating ONE complete status. The ```params[:statuses]``` hash only contains one set of status attrs.

TODO: look at these resources: http://guides.rubyonrails.org/form_helpers.html#building-complex-forms

### 8/16
(at SEPoCoNi)
Trying one more version of the form.

With help from Reid, I now have a form that creates multiple statuses. There are still problems, though:
- An extra status object is created, with :status and :goal_id nil.
- Report.user_id is nil

OK, fixed stuff. Here's what I learned:
- In Report#build_statuses, I had a sort of convoluted way of getting at goals: ```User.find(:user_id).goals``` Here's a prettier way to say it: ```self.user.goals```
- In ReportsController#create, we tried several ways of assigning @report:
	- ```@report = Report.create!(params[:report])``` - This led to a nil user_id, because although :user_id was present in params, it wasn't part of the :report hash.
	- ```@report = Report.create!(:report_date => params[:report], :user_id => params[:user_id])``` - This took care of the user_id problem, but it led to the creation of only a single status per report.
	- ```@report = @user.reports.create(params[:report])``` - This works, creating both the report and status objects.
- Inside a form_for, you can access the current object by calling .object on the form builder

NEXT:
- Create flash message to indicate successful create action
- Build forms for creating new users and goals


### QUESTIONS
- How to install debugger without breaking the server?

### TODO
- Figure out time zone stuff - looks like the default is GMT. Will want to use the user's local time instead.
- Will want to prevent users from submitting more than one report per day - validate uniqueness on date, and deal with error handling.
- Other goal trackers to check out:
	- http://www.lucidtracker.com/
	- MyChain android app

### NOTES FOR FUTURE VERSIONS
- Will want to allow for inactive goals to remain in the user's history - deleting a goal should not remove the data already collected. (addressed this on 8/8 with Goal state attr)
- Implement Jeff's suggestions from 8/10
