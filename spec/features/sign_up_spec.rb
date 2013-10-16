require 'spec_helper'

feature 'Sign up' do

  scenario 'User signs up with valid information' do
    # Given I am on the sign up page
    visit new_user_registration_path
    # When I fill in and submit the form
    fill_in 'Name', with: 'Jimmy'
    fill_in 'Email', with: 'jim@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    # Then I should be on the home page
    page.should have_no_text 'Sign up'
    page.should have_text 'Welcome home'
    # And I should have an associated Person with its name set
    jim_person = User.where(email: 'jim@example.com').first.person
    jim_person.name.should == 'Jimmy'
  end

  scenario 'User signs up with mismatched passwords' do
    # Given I am on the sign up page
    visit new_user_registration_path
    # When I fill in and submit the form with bad data
    # fill_in 'Name', with: 'Jimmy'
    fill_in 'Email', with: 'jim@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'wordpass'
    click_button 'Sign up'
    # Then I should stay on the page
    page.should have_text 'Sign up'
    # And I should see an error message
    page.should have_text 'error'
  end

  scenario 'User signs up with non-unique email' do
    # Given a user exists
    joe = FactoryGirl.create :user
    # And I am on the sign up page
    visit new_user_registration_path
    # When I fill in and submit the form with bad data
    # fill_in 'Name', with: 'Jimmy'
    fill_in 'Email', with: joe.email
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    # Then I should stay on the page
    page.should have_text 'Sign up'
    # And I should see an error message
    page.should have_text 'been taken'
  end

end
