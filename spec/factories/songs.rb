# == Schema Information
#
# Table name: songs
#
#  id           :bigint(8)        not null, primary key
#  name         :string(255)
#  track_number :integer
#  album_id     :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :song do
    
  end
end
