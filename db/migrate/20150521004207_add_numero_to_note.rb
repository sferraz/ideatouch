class AddNumeroToNote < ActiveRecord::Migration
  def change
    add_column :notes, :numerodanota, :integer
  end
end
