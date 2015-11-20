class AddAttachmentAvatarToParticipants < ActiveRecord::Migration
  def self.up
    change_table :participants do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :participants, :avatar
  end
end
