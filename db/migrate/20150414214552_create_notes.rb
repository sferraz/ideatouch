class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :board, index: true
      t.text :text

      t.timestamps null: false
    end
    add_foreign_key :notes, :boards
  end
end
