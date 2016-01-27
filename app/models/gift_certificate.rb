# == Schema Information
#
# Table name: gift_certificates
#
#  id                 :integer          not null, primary key
#  customer_id        :integer
#  active             :boolean          default("true")
#  date_redeemed      :date
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  business_id        :integer
#  certificate_number :integer
#  initial_comment    :text
#  redemption_comment :text
#

class GiftCertificate < ActiveRecord::Base
  belongs_to :customer
  belongs_to :business
  
  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true
  
  has_many :prices, as: :cost
  accepts_nested_attributes_for :prices, allow_destroy: true
  
  
end
