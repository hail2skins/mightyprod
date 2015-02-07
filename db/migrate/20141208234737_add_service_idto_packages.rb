class AddServiceIdtoPackages < ActiveRecord::Migration
  def change
    add_column :packages, :service_id, :integer, index: true
  end
end