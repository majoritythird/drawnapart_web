FactoryGirl.define do
  factory :person do
    name 'Joe'

    factory :person_with_user do
      user
    end
  end
end
