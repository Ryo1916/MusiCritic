# == Schema Information
#
# Table name: artists
#
#  id            :bigint(8)        not null, primary key
#  name          :string(255)
#  image         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  external_urls :string(255)
#

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
