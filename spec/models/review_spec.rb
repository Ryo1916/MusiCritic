# == Schema Information
#
# Table name: reviews
#
#  id         :bigint(8)        not null, primary key
#  title      :string(255)
#  rating     :float(24)
#  text       :text(65535)
#  user_id    :bigint(8)
#  album_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Review, type: :model do
  # Association test
  # ensure a review recored belongs to a single user/album record
  it { should belong_to(:user) }
  it { should belong_to(:album) }

  # Validations test
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:album_id) }
  it { should validate_presence_of(:rating) }
  it do
    should validate_numericality_of(:rating).
      is_greater_than_or_equal_to(0).
      is_less_than_or_equal_to(5)
  end
end
