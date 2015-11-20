class User < ActiveRecord::Base
  include Clearance::User
  has_many :Dynamics
  has_many :Notifications
end
