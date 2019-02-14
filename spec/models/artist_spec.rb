# == Schema Information
#
# Table name: artists
#
#  id           :bigint(8)        not null, primary key
#  artist       :string(255)
#  artist_image :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Artist, type: :model do
  # Association tests
  # ensure Artist model has a 1:m relationship with the Album and Songs model
  it { should have_many(:albums).dependent(:destroy) }
  it { should have_many(:songs).dependent(:destroy) }

  # Validation test
  # ensure column artist is present before saving
  it { should validate_presence_of(:artist) }
end
