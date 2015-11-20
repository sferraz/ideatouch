class AddNameToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :name, :string
  end
end
