require 'spec_helper'

include ApiSteps

describe 'API for People' do

  let!(:person) { FactoryGirl.create :person_with_user }
  let(:user) { person.user }

  context 'GET /api/v1/people/:id' do

    it 'Returns a 200' do
      get_person
      response.status.should eq 200
    end

    it 'Returns a 401 with the wrong auth token' do
      jhr(:get, api_v1_person_path(person), nil, 'HTTP_AUTHORIZATION' => "Token token=\"abc123\"")
      response.status.should eq 401
    end

    it 'Returns a 401 with no auth token' do
      jhr(:get, api_v1_person_path(person), nil)
      response.status.should eq 401
    end

    it 'Response json contains the person' do
      get_person
      json_response.should match_json_expression({person: {name: 'Joe', links: {user: User.last.id}}.ignore_extra_keys!}.ignore_extra_keys!)
    end

    it 'Response json contains the user' do
      get_person
      json_response.should match_json_expression({user: {email: User.last.email}.ignore_extra_keys!}.ignore_extra_keys!)
    end

  end

  def get_person
    jhr(:get, api_v1_person_path(person), nil, 'HTTP_AUTHORIZATION' => "Token token=\"#{user.authentication_token}\"")
  end

end
