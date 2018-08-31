class AddShowTimeToConcerts < ActiveRecord::Migration[5.0]
  def change
    remove_column :concerts, :show_time
    add_column :concerts, :show_time, :datetime, null: false
  end
end
