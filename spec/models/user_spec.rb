require 'rails_helper'

RSpec.describe User, type: :model do
  # Validations test
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

  # Associations test
  it { should have_many(:reviews).dependent(:destroy) }

  # TODO: メソッドのテスト
end
