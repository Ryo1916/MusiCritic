require 'rails_helper'

RSpec.feature 'Signups', type: :feature do
  background do
    ActionMailer::Base.deliveries.clear
  end

  feature 'Signup flow' do
    let!(:user) { create(:user) }

    scenario 'Success' do
      # Create an account
      visit new_user_registration_path
      within('#new_user') do
        fill_in 'Name', with: 'new_signup_user'
        fill_in 'Email', with: 'new_signup_user@test.abc'
        fill_in 'Password', with: 'newsignupuserpassword'
        fill_in 'Password confirmation', with: 'newsignupuserpassword'
      end
      expect { click_button 'Create your account' }.to change { ActionMailer::Base.deliveries.size }.by(1)
      expect(page).to have_content 'A message with a confirmation link has been sent to your email address'

      # Check the confirmation email
      user = User.last
      token = user.confirmation_token
      visit "/users/confirmation?confirmation_token=#{token}"

      # Login with the new account
      within('#new_user') do
        fill_in 'Email', with: 'new_signup_user@test.abc'
        fill_in 'Password', with: 'newsignupuserpassword'
        click_button 'Log in'
      end
      expect(page).to have_content 'Signed in successfully.'

      # Logout
      within('.navbar-right') do
        click_link 'Logout'
      end
      expect(page).to have_content 'Signed out successfully.'
    end

    scenario "Name can't be blank" do
      visit new_user_registration_path
      within('#new_user') do
        fill_in 'Name', with: ''
        fill_in 'Email', with: 'new_signup_user@test.abc'
        fill_in 'Password', with: 'newsignupuserpassword'
        fill_in 'Password confirmation', with: 'newsignupuserpassword'
      end
      click_button 'Create your account'
      expect(page).to have_content "Name can't be blank"
    end

    scenario 'Name has already been taken' do
      visit new_user_registration_path
      within('#new_user') do
        fill_in 'Name', with: 'josie'
        fill_in 'Email', with: 'new_signup_user@test.abc'
        fill_in 'Password', with: 'newsignupuserpassword'
        fill_in 'Password confirmation', with: 'newsignupuserpassword'
      end
      click_button 'Create your account'
      expect(page).to have_content "Name has already been taken" 
    end

    scenario "Email can't be blank" do
      visit new_user_registration_path
      within('#new_user') do
        fill_in 'Name', with: 'new_signup_user'
        fill_in 'Email', with: ''
        fill_in 'Password', with: 'newsignupuserpassword'
        fill_in 'Password confirmation', with: 'newsignupuserpassword'
      end
      click_button 'Create your account'
      expect(page).to have_content "Email can't be blank" 
    end

    scenario "Email is invalid" do
      visit new_user_registration_path
      within('#new_user') do
        fill_in 'Name', with: 'new_signup_user'
        fill_in 'Email', with: 'new_signup_user@test..'
        fill_in 'Password', with: 'newsignupuserpassword'
        fill_in 'Password confirmation', with: 'newsignupuserpassword'
      end
      click_button 'Create your account'
      expect(page).to have_content 'Email is invalid'
    end

    scenario 'Email has already been taken' do
      visit new_user_registration_path
      within('#new_user') do
        fill_in 'Name', with: 'new_signup_user'
        fill_in 'Email', with: 'josie@test.abc'
        fill_in 'Password', with: 'newsignupuserpassword'
        fill_in 'Password confirmation', with: 'newsignupuserpassword'
      end
      click_button 'Create your account'
      expect(page).to have_content 'Email has already been taken'
    end

    scenario "Password can't be blank" do
      visit new_user_registration_path
      within('#new_user') do
        fill_in 'Name', with: 'new_signup_user'
        fill_in 'Email', with: 'new_signup_user@test.abc'
        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: 'newsignupuserpassword'
      end
      click_button 'Create your account'
      expect(page).to have_content "Password can't be blank"
    end
  end
end
