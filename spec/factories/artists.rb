FactoryBot.define do
  factory :artist do
    artist { Faker::Music.band }
    artist_image { Faker::Avator.image }
  end

  factory :user do
    name "josie"
    email "josie@test.abc"
    password "password"
    password_confirmation "password"
    confirmed_at Time.now
  end
end
