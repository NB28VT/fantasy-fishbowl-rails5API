FactoryBot.define do
  factory :prediction_category do
    name { Faker::Hipster.word }
    setlist_position {rand(1..10)}
    set_number {rand(1..3)}
  end
end
