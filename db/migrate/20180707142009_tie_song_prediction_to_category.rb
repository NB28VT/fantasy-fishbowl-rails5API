class TieSongPredictionToCategory < ActiveRecord::Migration[5.0]
  def change
    remove_column :song_predictions, :set_position
    remove_column :song_predictions, :setlist_position
    add_column :song_predictions, :prediction_category_id, :integer, index: true, foreign_key: true
  end
end
