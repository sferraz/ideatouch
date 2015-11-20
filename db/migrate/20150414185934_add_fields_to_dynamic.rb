class AddFieldsToDynamic < ActiveRecord::Migration
  def change
    add_reference :dynamics, :user, index: true
    add_foreign_key :dynamics, :users
  end
end
