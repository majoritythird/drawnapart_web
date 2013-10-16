class Person < ActiveRecord::Base

  has_one :user, :inverse_of => :person

  delegate :email, :to => :user

  validates_presence_of :name

end
