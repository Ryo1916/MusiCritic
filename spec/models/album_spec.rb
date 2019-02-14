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

require 'rails_helper'

RSpec.describe Album, type: :model do
  # Associations test
  # ensure an album recored belongs to a single artist record
  it { should belong_to(:artist) }

  # ensure Album model has a 1:m relationship with the Songs and Reviews model
  it { should have_many(:songs).dependent(:destroy) }
  it { should have_many(:reviews).dependent(:destroy) }

  # ensure Album model accepts nested attributes for songs
  it { should accept_nested_attributes_for(:songs).allow_destroy(true) }

  # Validations test
  it { should validate_presence_of(:album_name) }
  it { should validate_presence_of(:release) }
  it { should validate_presence_of(:genre) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:album_image) }
  it { should validate_presence_of(:artist_id) }

end
