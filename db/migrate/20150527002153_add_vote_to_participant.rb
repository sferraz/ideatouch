class AddVoteToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :vote, :boolean
  end
end
