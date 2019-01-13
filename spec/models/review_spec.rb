require 'rails_helper'

RSpec.describe Review, type: :model do
  # Association test
  # ensure a review recored belongs to a single user record
  it { should belong_to(:user) }

  # Validations test
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:album_id) }
end
