class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name, index: true
      t.string :middle_name
      t.string :last_name, index: true
      t.integer :phone, index: true
      t.string :referred_by
      t.references :business, index: true
      t.string :email, index:true

      t.timestamps
    end
  end
end
