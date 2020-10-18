# frozen_string_literal: true

class UpdateUserRequestParams < BaseRequestParams
  attribute :name, :string
  attribute :email, :string
  attribute :avatar # FIXME: ActionDispatch::Http::UploadedFileで型定義

  validates :name, :email, presence: true

  def initialize(params)
    super(params['user'].permit(
      :name,
      :email,
      :avatar
    ))
  end
end
