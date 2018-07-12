class ColumnUpdatesForConcertPredictions < ActiveRecord::Migration[5.0]
  def change
    rename_column :concert_predictions, :submission_score, :score
  end
end
