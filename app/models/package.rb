# == Schema Information
#
# Table name: packages
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  count       :integer
#  business_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Package < ActiveRecord::Base
  belongs_to :business

  has_many :prices, as: :cost
  accepts_nested_attributes_for :prices
  
  validates_presence_of :name, message: "Package Name can't be blank."
  validates_presence_of :count, presence: true, message: "Number of visits in package can't be blank."

end
