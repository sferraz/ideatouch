class AddFieldsToNote < ActiveRecord::Migration
  def change
    add_column :notes, :color, :string
  end
end
