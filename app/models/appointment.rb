# == Schema Information
#
# Table name: appointments
#
#  id         :integer          not null, primary key
#  service_id :integer
#  visit_id   :integer
#  amount     :decimal(8, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Appointment < ActiveRecord::Base
  belongs_to :service
  belongs_to :visit
end
