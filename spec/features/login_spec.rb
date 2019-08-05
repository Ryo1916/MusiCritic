require "rails_helper"

feature "GET /users/sign_in" do
  scenario "Select Login link, and then go to login page" do
    visit new_user_session_path
    click_on "Login"
    expect(current_path).to eq new_user_session_path
  end
end

feature "POST/DELETE /users/sign_in" do
  let!(:user) { create(:user) }

  scenario "Go to login page, login from the login form and then logout" do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'Email', with: 'josie@test.abc'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content
    within('.navbar-right') do
      click_link 'Logout'
    end
  end
end
