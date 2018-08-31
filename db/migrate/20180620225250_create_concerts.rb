class CreateConcerts < ActiveRecord::Migration[5.0]
  def change
    create_table :concerts do |t|
      t.string :venue_name
      t.date :show_time

      t.timestamps
    end
  end
end
