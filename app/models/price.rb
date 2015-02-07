# == Schema Information
#
# Table name: prices
#
#  id         :integer          not null, primary key
#  amount     :decimal(8, 2)
#  cost_id    :integer
#  cost_type  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Price < ActiveRecord::Base
  belongs_to :cost, polymorphic: true
  
  validates_presence_of :amount
end
