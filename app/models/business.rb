# == Schema Information
#
# Table name: businesses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  owner_id    :integer
#  selected    :boolean          default("false")
#

class Business < ActiveRecord::Base
	acts_as_paranoid
	
	belongs_to :owner
	has_one :categories
	accepts_nested_attributes_for :categories

	has_many :customers, dependent: :destroy
  has_many :visits, through: :customers
 
  has_many :packages
  has_many :deals, through: :customers
  
  has_many :services, -> { not_deleted }
  has_many :notifications
  has_many :gift_certificates
  has_many :comps

	validates :owner_id, presence: true
	validates :name, presence: true
	
  scope :not_deleted, -> { where(deleted_at: NIL) }
	
end
