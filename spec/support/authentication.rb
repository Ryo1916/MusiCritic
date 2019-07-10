module Authentication
  def login
    let(:user) { create(:user) }
    before do
      sign_in user
    end
  end
end
