FactoryGirl.define do

  factory :user do
    email 'joe@example.com'
    password 'password'

    factory :user_with_person do
      person
    end

  end
end
