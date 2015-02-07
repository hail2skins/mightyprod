class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.text :visit_notes
      t.date :date_of_visit
      t.references :customer, index: true

      t.timestamps
    end
  end
end
