class Participant < ActiveRecord::Base
  belongs_to :dynamic
  has_many :votes

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
