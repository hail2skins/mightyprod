# == Schema Information
#
# Table name: comps
#
#  id          :integer          not null, primary key
#  date_comp   :date
#  amount_comp :decimal(8, 2)
#  active      :boolean          default("false")
#  business_id :integer
#  visit_id    :integer
#  customer_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Comp < ActiveRecord::Base
  belongs_to :business
  belongs_to :visit
  belongs_to :customer
  
end
