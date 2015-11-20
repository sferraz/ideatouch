class Vote < ActiveRecord::Base
  belongs_to :participant
  belongs_to :dynamic
  belongs_to :note
end
