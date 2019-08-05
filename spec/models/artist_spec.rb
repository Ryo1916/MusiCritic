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
#  spotify_id    :string(255)      not null
#

require 'rails_helper'

RSpec.describe Artist, type: :model do
  # Association tests
  it { should have_many(:artists_albums).dependent(:destroy) }
  it { should have_many(:albums).through(:artists_albums) }

  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:image) }
  it { should validate_presence_of(:external_urls) }
  it { should validate_presence_of(:spotify_id) }

  # TODO: メソッドのテスト
end
