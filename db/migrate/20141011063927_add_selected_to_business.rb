class AddSelectedToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :selected, :boolean, default: false
  end
end
