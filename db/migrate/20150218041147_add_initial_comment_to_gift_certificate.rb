class AddInitialCommentToGiftCertificate < ActiveRecord::Migration
  def change
    add_column :gift_certificates, :initial_comment, :text, index: true
    add_column :gift_certificates, :redemption_comment, :text, index: true
  end
end
