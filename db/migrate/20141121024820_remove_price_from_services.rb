class RemovePriceFromServices < ActiveRecord::Migration
  def change
    remove_column :services, :price
  end
end
