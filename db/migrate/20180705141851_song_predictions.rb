class SongPredictions < ActiveRecord::Migration[5.0]
  def change
    create_table :song_predictions do |t|
      t.references :concert_prediction, foreign_key: true
      t.references :song, foreign_key: true
      t.integer :set_position
      t.integer :setlist_position

      t.timestamps
    end
  end
end
