require 'spec_helper'

feature 'Sign in' do

  scenario 'User signs in with valid information' do
    # Given a user exists
    joe = FactoryGirl.create :user
    # And I am on the sign in page
    visit new_user_session_path
    # When I fill in and submit the form
    fill_in 'Email', with: joe.email
    fill_in 'Password', with: joe.password
    click_button 'Sign in'
    # Then I should be on the home page
    page.should have_no_text 'Sign in'
    page.should have_text 'Welcome home'
  end

  scenario 'User signs in with bad password' do
    # Given a user exists
    joe = FactoryGirl.create :user
    # And I am on the sign in page
    visit new_user_session_path
    # When I fill in and submit the form with bad data
    fill_in 'Email', with: joe.email
    fill_in 'Password', with: 'foop'
    click_button 'Sign in'
    # Then I should stay on the page
    page.should have_text 'Sign in'
    # And I should see an error message
    page.should have_text 'Invalid email or password'
  end

end
