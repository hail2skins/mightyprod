class AddIndexForDeletedAtToOwners < ActiveRecord::Migration
  def change
    add_index :owners, :deleted_at
  end
end
