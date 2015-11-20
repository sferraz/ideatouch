class AddVotationToDynamic < ActiveRecord::Migration
  def change
    add_column :dynamics, :votation, :boolean
  end
end
