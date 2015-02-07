class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.references :business, index: true

      t.timestamps
    end
  end
end
