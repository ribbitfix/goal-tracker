class User < ActiveRecord::Base
  attr_accessible :user_name, :email, :password, :password_confirmation, :goals_attributes
  has_secure_password
  has_many :goals
  has_many :reports
  accepts_nested_attributes_for :goals

  validates :user_name, :presence => true, :uniqueness => {:case_sensitive => false}
  validates :email, :presence => true, :uniqueness => true, :format => /@/
  validates :password, :presence => {:on => :create}
end
