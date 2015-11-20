class AddDynamicToNote < ActiveRecord::Migration
  def change
    add_reference :notes, :dynamic, index: true
    add_foreign_key :notes, :dynamics
  end
end
