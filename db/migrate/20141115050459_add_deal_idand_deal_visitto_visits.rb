class AddDealIdandDealVisittoVisits < ActiveRecord::Migration
  def change
    add_column :visits, :deal_id, :integer, index: true
    add_column :visits, :deal_visit, :boolean, default: false, index: true
  end
end
