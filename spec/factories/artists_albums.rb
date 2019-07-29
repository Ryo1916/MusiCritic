# == Schema Information
#
# Table name: artists_albums
#
#  id         :bigint(8)        not null, primary key
#  artist_id  :integer
#  album_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :artists_album do
    artist_id { nil }
    album_id { nil }
  end
end
