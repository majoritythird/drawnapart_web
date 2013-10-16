class Person < ActiveRecord::Base

  has_one :user, :inverse_of => :person

  delegate :email, :to => :user

end
