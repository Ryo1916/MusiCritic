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

require 'rails_helper'

RSpec.describe Song, type: :model do
  # Associations test
  # ensure a song recored belongs to a single artist and album record
  it { should belong_to(:artist) }
  it { should belong_to(:album) }

  # Validations test
  it { should validate_presence_of(:song_name) }
  it { should validate_presence_of(:track_num) }
  it { should validate_presence_of(:artist_id) }
  it { should validate_presence_of(:album_id) }

end
