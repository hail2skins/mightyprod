class RemoveDatePurchasedfromPackages < ActiveRecord::Migration
  def change
    remove_column :packages, :date_purchased
  end
end
