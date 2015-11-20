class AddVotationNumberToDynamic < ActiveRecord::Migration
  def change
    add_column :dynamics, :votationnumber, :integer
  end
end
