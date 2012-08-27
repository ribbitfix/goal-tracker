class User < ActiveRecord::Base
  attr_accessible :user_name, :goals_attributes
  has_many :goals
  has_many :reports
  accepts_nested_attributes_for :goals
end
