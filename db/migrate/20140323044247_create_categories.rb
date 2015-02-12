class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.belongs_to :business
      t.belongs_to :service

      t.timestamps
    end
    add_index :categories, [:business_id, :service_id], unique: true
  end
end
