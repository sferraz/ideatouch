class Dynamic < ActiveRecord::Base
  belongs_to :user
  has_many :boards
  accepts_nested_attributes_for :boards
  has_many :participants
  has_many :notes
  has_many :votes
end
