# == Schema Information
#
# Table name: albums
#
#  id            :bigint(8)        not null, primary key
#  name          :string(255)
#  release_date  :string(255)
#  external_urls :string(255)
#  image         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  reviews_count :integer          default(0), not null
#  spotify_id    :string(255)      not null
#

require 'rails_helper'

RSpec.describe Album, type: :model do
  # Associations test
  it { should belong_to(:artist) }
  it { should have_many(:songs).dependent(:destroy) }
  it { should have_many(:reviews).dependent(:destroy) }

  # Validations test
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:release_date) }
  it { should validate_presence_of(:external_urls) }
  it { should validate_presence_of(:image) }
  it { should validate_presence_of(:artist_id) }

  # TODO: メソッドのテスト
end
