FactoryBot.define do
  factory :song_performance do
    concert_set
    song
    sequence(:setlist_position)
  end
end
