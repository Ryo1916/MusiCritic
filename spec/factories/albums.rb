# == Schema Information
#
# Table name: albums
#
#  id            :bigint(8)        not null, primary key
#  name          :string(255)
#  release_date  :string(255)
#  external_urls :string(255)
#  image         :string(255)
#  artist_id     :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  reviews_count :integer          default(0), not null
#  spotify_id    :string(255)      not null
#

FactoryBot.define do
  factory :album do
    
  end
end
