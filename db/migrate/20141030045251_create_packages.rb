class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.text :description
      t.integer :count
      t.date :date_purchased
      t.references :business, index: true

      t.timestamps
    end
  end
end
