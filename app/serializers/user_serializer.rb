class UserSerializer < ActiveModel::Serializer

  embed :ids, include: true

  attributes :authentication_token, :created_at, :email, :id, :links, :updated_at
  has_one :person

  def links
    {:person => person.id}
  end

end
