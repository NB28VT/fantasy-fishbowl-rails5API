class CreateConcertTour < ActiveRecord::Migration[5.0]
  def change
    create_table :concert_tours do |t|
      t.string :name

      t.timestamps
    end
  end
end
