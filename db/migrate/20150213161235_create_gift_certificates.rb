class CreateGiftCertificates < ActiveRecord::Migration
  def change
    create_table :gift_certificates do |t|
      t.references :customer, index: true
      t.boolean :active, default: true, index: true
      t.date :date_redeemed, index: true

      t.timestamps null: false
    end
    add_foreign_key :gift_certificates, :customers
  end
end
