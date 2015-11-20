class Board < ActiveRecord::Base
  belongs_to :dynamic
  has_many :notes
  accepts_nested_attributes_for :notes
end
