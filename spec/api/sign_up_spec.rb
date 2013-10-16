require 'spec_helper'

include ApiSteps

describe 'API Sign up' do

  context 'Valid sign up' do
    it 'returns a 201 response' do
      sign_up
      response.status.should eq 201
    end

    it 'Response json contains the person' do
      sign_up
      json_response.should match_json_expression({person: {name: 'Joe', links: {user: User.last.id}}.ignore_extra_keys!}.ignore_extra_keys!)
    end

    it 'Response json contains the user' do
      sign_up
      json_response.should match_json_expression({user: {email: User.last.email}.ignore_extra_keys!}.ignore_extra_keys!)
    end

  end

  context 'Invalid sign up' do
    it 'returns a 422' do
      existing_user = FactoryGirl.create :user, email: 'joe@example.com'
      sign_up existing_user.email
      response.status.should eq 422
    end

    it 'Contains error messaging' do
      existing_user = FactoryGirl.create :user, email: 'joe@example.com'
      sign_up existing_user.email
      json_response.should match_json_expression({errors: {email: ['has already been taken']}}.ignore_extra_keys!)
    end

  end

  def sign_up(email = 'joe@example.com')
    jhr(:post, api_v1_sign_up_path, {
      user: {
        person_attributes: {
          name: 'Joe'
        },
        email: email,
        password: 'password',
      }
    })
  end

end
