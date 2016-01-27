# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  subject     :string
#  body        :text
#  business_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Notification < ActiveRecord::Base
  
  belongs_to :business
  
end
