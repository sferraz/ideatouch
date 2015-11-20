class AddColorToDynamic < ActiveRecord::Migration
  def change
    add_column :dynamics, :color, :string
  end
end
