class AddBusinessIdToVisits < ActiveRecord::Migration
  def change
    add_reference :visits, :business, index: true
  end
end
