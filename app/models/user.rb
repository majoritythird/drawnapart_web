class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :ensure_authentication_token

  belongs_to :person, :inverse_of => :user

  accepts_nested_attributes_for :person

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def as_json(options = {})
    {
      person: person.as_json_person,
      user: as_json_user
    }
  end

  def as_json_user
    {
      authentication_token: authentication_token,
      created_at: created_at,
      email: email,
      id: id,
      links:
      {
        person: person.id
      },
      updated_at: updated_at
    }
  end
 
  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end
