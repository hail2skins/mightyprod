class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number, limit: 10
      t.references :phoneable, polymorphic: true

      t.timestamps
    end
    add_index :phones, [:phoneable_type, :phoneable_id]
  end
end
