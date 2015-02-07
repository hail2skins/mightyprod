# == Schema Information
#
# Table name: deals
#
#  id             :integer          not null, primary key
#  customer_id    :integer
#  date_purchased :date
#  date_completed :date
#  used_count     :integer
#  created_at     :datetime
#  updated_at     :datetime
#  package_id     :integer
#  business_id    :integer
#  active         :boolean          default(FALSE)
#

class Deal < ActiveRecord::Base
  belongs_to :customer
  belongs_to :business
  belongs_to :package
  
  accepts_nested_attributes_for :package
  
  validates_presence_of :date_purchased  
  validates_presence_of :package_id

  

end
