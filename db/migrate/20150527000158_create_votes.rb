class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :participant, index: true
      t.references :dynamic, index: true
      t.references :note, index: true

      t.timestamps null: false
    end
    add_foreign_key :votes, :participants
    add_foreign_key :votes, :dynamics
    add_foreign_key :votes, :notes
  end
end
