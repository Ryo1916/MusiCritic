require 'rails_helper'

RSpec.feature 'Logins', type: :feature do
  feature 'Login flow' do
    let!(:user) { create(:user) }

    scenario 'Success' do
      # Login with existing account by factories
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: "josie@test.abc"
        fill_in 'Password', with: "password"
        click_button 'Log in'
      end
      expect(page).to have_content 'Signed in successfully.'

      # Logout
      within('.navbar-right') do
        click_link 'Logout'
      end
      expect(page).to have_content 'Signed out successfully.'
    end

    scenario 'Fail' do
      visit new_user_session_path
      within('#new_user') do
        fill_in 'Email', with: 'josie@test.abc'
        fill_in 'Password', with: 'wrongpassword'
        click_button 'Log in'
      end
      expect(page).to have_content 'Invalid Email or password.'
      expect(current_path).to eq new_user_session_path
    end
  end
end
