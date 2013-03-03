class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :name
  
  has_secure_password
  
  validates_presence_of :password, :on => :create
  validates_presence_of :name
  validates_uniqueness_of :email

  has_many :reviews
end
