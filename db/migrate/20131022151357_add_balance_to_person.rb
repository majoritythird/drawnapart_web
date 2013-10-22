class AddBalanceToPerson < ActiveRecord::Migration
  def change
    add_column :people, :balance, :integer, default: 0
  end
end
