class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.references :business, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.date :start_date
      t.date :expiration_date
      t.integer :percentage

      t.timestamps null: false
    end
  end
end
