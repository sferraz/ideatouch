class AddTimeToDynamic < ActiveRecord::Migration
  def change
    add_column :dynamics, :final, :datetime
  end
end
