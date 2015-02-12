class AddOwnerIdToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :owner_id, :integer
    add_index :businesses, :name
  	add_index :businesses, :owner_id
  end

end
