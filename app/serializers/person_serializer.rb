class PersonSerializer < ActiveModel::Serializer

  embed :ids, include: true

  attributes :balance, :created_at, :id, :links, :name, :updated_at
  has_one :user

  def links
    {:user => user.id}
  end

end
