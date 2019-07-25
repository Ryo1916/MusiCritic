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
#  preview_url  :string(255)
#

require 'rails_helper'

RSpec.describe Song, type: :model do
  # Associations test
  it { should belong_to(:album) }

  # Validations test
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:track_number) }
  it { should validate_presence_of(:album_id) }

end
