class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :name
      t.text :descricao
      t.references :dynamic, index: true

      t.timestamps null: false
    end
    add_foreign_key :boards, :dynamics
  end
end
