# == Schema Information
#
# Table name: visits
#
#  id            :integer          not null, primary key
#  visit_notes   :text
#  date_of_visit :date
#  customer_id   :integer
#  created_at    :datetime
#  updated_at    :datetime
#  business_id   :integer
#  deal_id       :integer
#  deal_visit    :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Visit, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
