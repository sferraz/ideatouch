class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :email
      t.references :dynamic, index: true

      t.timestamps null: false
    end
    add_foreign_key :participants, :dynamics
  end
end
