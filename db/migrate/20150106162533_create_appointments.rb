class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :service, index: true
      t.references :visit, index: true
      t.decimal :amount, precision: 8, scale: 2, index: true

      t.timestamps null: false
    end
    add_foreign_key :appointments, :services
    add_foreign_key :appointments, :visits
  end
end
