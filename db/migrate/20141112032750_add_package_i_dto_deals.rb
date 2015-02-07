class AddPackageIDtoDeals < ActiveRecord::Migration
  def change
    add_column :deals, :package_id, :integer, index: true
  end
end
