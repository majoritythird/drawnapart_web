require 'spec_helper'

include ApiSteps

describe 'API Sign in' do

  context 'Valid sign in' do

    let!(:user) { FactoryGirl.create :user_with_person, email: 'joe@example.com', password: 'password' }

    it 'returns a 201 response' do
      sign_in
      response.status.should eq 201
    end

    it 'Response json contains the person' do
      sign_in
      json_response.should match_json_expression({people: [{name: 'Joe', links: {user: User.last.id}}.ignore_extra_keys!]}.ignore_extra_keys!)
    end

    it 'Response json contains the user' do
      sign_in
      json_response.should match_json_expression({user: {email: User.last.email}.ignore_extra_keys!}.ignore_extra_keys!)
    end

    it 'Response json contains the authentication token' do
      sign_in
      json_response.should match_json_expression({user: {authentication_token: User.last.authentication_token}.ignore_extra_keys!}.ignore_extra_keys!)
    end

    it 'Back-to-back sign-in with different user works' do
      lou = FactoryGirl.create :user_with_person, email: 'lou@example.com', password: 'password'
      sign_in user.email
      json_response.should match_json_expression({user: {authentication_token: user.authentication_token, id: user.id}.ignore_extra_keys!}.ignore_extra_keys!)
      sign_in lou.email
      json_response.should match_json_expression({user: {authentication_token: lou.authentication_token, id: lou.id}.ignore_extra_keys!}.ignore_extra_keys!)
    end

  end

  def sign_in(email = 'joe@example.com')
    jhr(:post, api_sign_in_path, {
      user: {
        email: email,
        password: user.password,
      }
    })
  end

end
