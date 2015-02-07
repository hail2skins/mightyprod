class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.references :customer, index: true
      t.date :date_purchased
      t.date :date_completed
      t.integer :used_count

      t.timestamps
    end
  end
end
