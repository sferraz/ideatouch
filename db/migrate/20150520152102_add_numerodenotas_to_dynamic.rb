class AddNumerodenotasToDynamic < ActiveRecord::Migration
  def change
    add_column :dynamics, :numerodenotas, :integer
  end
end
