class CreateConcertSets < ActiveRecord::Migration[5.0]
  def change
    create_table :concert_sets do |t|
      t.belongs_to :concert, index: true, foreign_key: true
      t.integer :set_number

      t.timestamps
    end
  end
end
