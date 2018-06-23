class CreateSongPerformances < ActiveRecord::Migration[5.0]
  def change
    create_table :song_performances do |t|
      t.references :concert_set, foreign_key: true
      t.references :song, foreign_key: true
      t.integer :setlist_position

      t.timestamps
    end
  end
end
