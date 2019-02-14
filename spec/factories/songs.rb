# == Schema Information
#
# Table name: songs
#
#  id         :bigint(8)        not null, primary key
#  song_name  :string(255)
#  track_num  :integer
#  artist_id  :bigint(8)
#  album_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :song do
    
  end
end
