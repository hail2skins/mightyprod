class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.references :commentable, polymorphic: true

      t.timestamps null: false
    end
  add_index :comments, [:commentable_type, :commentable_id], unique: true
  end
end


