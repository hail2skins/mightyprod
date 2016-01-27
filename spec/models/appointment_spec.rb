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

require 'rails_helper'

RSpec.describe Appointment, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
