require 'spec_helper'

describe Person do
  
  it 'Has the correct JSON representation of the Person' do
    joe = FactoryGirl.create :person_with_user, name: 'Joe', balance: '120'
    expected = {person: {balance: joe.balance, id: joe.id, name: joe.name, links: {user: joe.user.id}}.ignore_extra_keys!}.ignore_extra_keys!
    PersonSerializer.new(joe).as_json.should match_json_expression expected
  end

  it 'Has the correct JSON representation of the User' do
    joe = FactoryGirl.create :person_with_user, name: 'Joe', balance: '120'
    expected = {users: [{email: joe.user.email, id: joe.user.id}.ignore_extra_keys!]}.ignore_extra_keys!
    PersonSerializer.new(joe).as_json.should match_json_expression expected
  end

end
