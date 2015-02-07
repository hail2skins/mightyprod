class AddActivetoDeals < ActiveRecord::Migration
  def change
    add_column :deals, :active, :boolean, default: false, index: true
  end
end
