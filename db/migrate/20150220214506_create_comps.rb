class CreateComps < ActiveRecord::Migration
  def change
    create_table :comps do |t|
      t.date :date_comp, index: true
      t.decimal :amount_comp, precision: 8, scale: 2, index: true
      t.boolean :active, default: false, index: true
      t.references :business, index: true
      t.references :visit, index: true
      t.references :customer, index: true

      t.timestamps null: false
    end
    add_foreign_key :comps, :businesses
    add_foreign_key :comps, :visits
    add_foreign_key :comps, :customers
  end
end
