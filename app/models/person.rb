class Person < ActiveRecord::Base

  has_one :user, :inverse_of => :person

  delegate :email, :to => :user

  validates_presence_of :name

  def as_json(options = {})
    {
      person: 
        {
          created_at: created_at,
          id: id,
          name: name,
          updated_at: updated_at,
          links:
            {
              user: user.id
            }
        },
        user:
          {
            authentication_token: user.authentication_token,
            created_at: user.created_at,
            email: user.email,
            id: user.id,
            updated_at: user.updated_at
          }
      }
  end

end
