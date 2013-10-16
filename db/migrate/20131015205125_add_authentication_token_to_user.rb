class AddAuthenticationTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string
    add_column :users, :person_id, :integer
  end
end
