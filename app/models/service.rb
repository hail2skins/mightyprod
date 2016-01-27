# == Schema Information
#
# Table name: services
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  business_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Service < ActiveRecord::Base
  belongs_to :business
  belongs_to :package
  
  has_many :prices, as: :cost
  accepts_nested_attributes_for :prices
  
  has_many :appointments
  has_many :visits, through: :appointments
  
  validates_presence_of :name
  
  before_save :titleize_name
  
  scope :not_deleted, -> { where(deleted_at: NIL) }
  
  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end
  
  private
    def titleize_name
      self.name = name.titleize
    end
end
