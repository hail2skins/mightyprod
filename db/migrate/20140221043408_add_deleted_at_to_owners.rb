class AddDeletedAtToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :deleted_at, :datetime
  end
end
