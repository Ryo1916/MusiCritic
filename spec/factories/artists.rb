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
    name { Faker::Music.band }
    image { Faker::Avator.image }
  end
end
