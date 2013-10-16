require 'spec_helper'

describe User do
  
  it 'Generates an authentication_token when created' do
    joe = FactoryGirl.build :user
    joe.authentication_token.should be_nil
    joe.save
    joe.authentication_token.should_not be_nil
  end

end
