class ChangePredictionScoreDefaultToNil < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:concert_predictions, :score, nil)
  end
end
