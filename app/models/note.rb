class Note < ActiveRecord::Base
  belongs_to :board
  belongs_to :dynamic
  has_many :votes
end
