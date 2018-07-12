class CreateConcertPredictions < ActiveRecord::Migration[5.0]
  def change
    create_table :concert_predictions do |t|
      t.references :user, foreign_key: true
      t.references :concert, foreign_key: true
      t.integer :submission_score, default: 0

      t.timestamps
    end
  end
end
