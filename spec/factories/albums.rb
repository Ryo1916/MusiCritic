# == Schema Information
#
# Table name: albums
#
#  id          :bigint(8)        not null, primary key
#  album_name  :string(255)
#  release     :date
#  genre       :string(255)
#  description :text(65535)
#  album_image :string(255)
#  artist_id   :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :album do
    
  end
end
