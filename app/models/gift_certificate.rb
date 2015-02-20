class GiftCertificate < ActiveRecord::Base
  belongs_to :customer
  belongs_to :business
  
  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true
  
  has_many :prices, as: :cost
  accepts_nested_attributes_for :prices, allow_destroy: true
  
  
end
