class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :subject
      t.text :body
      t.references :business, index: true

      t.timestamps null: false
    end
  end
end
