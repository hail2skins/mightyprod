class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.references :cost, polymorphic:true
      
      t.timestamps
    end
  add_index :prices, [:cost_type, :cost_id], unique: true
  end
end
