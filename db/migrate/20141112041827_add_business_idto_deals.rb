class AddBusinessIdtoDeals < ActiveRecord::Migration
  def change
    add_column :deals, :business_id, :integer, index: true
  end
end
