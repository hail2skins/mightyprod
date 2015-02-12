class AddIndexForDeletedAtToBusinesses < ActiveRecord::Migration
  def change
    add_index :businesses, :deleted_at
  end
end
