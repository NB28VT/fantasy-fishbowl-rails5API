class AddSetNumberAndSetPositionToPredictionCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :prediction_categories, :set_number, :integer
    add_column :prediction_categories, :setlist_position, :integer
  end
end
