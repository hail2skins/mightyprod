class AddCertificateNumberToGiftCertificate < ActiveRecord::Migration
  def change
    add_reference :gift_certificates, :business, index: true
    add_foreign_key :gift_certificates, :businesses
    add_column :gift_certificates, :certificate_number, :integer, index: true
  end
end