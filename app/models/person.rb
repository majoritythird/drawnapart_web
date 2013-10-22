class Person < ActiveRecord::Base

  has_one :user, :inverse_of => :person

  delegate :email, :to => :user

  validates_presence_of :name

  def as_json(options = {})
    {
      person: as_json_person,
      user: user.as_json_user
    }
  end

  def as_json_person
    {
      balance: balance,
      created_at: created_at,
      id: id,
      links:
      {
        user: user.id
      },
      name: name,
      updated_at: updated_at,
    }
  end

end
