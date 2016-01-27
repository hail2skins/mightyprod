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
#  active         :boolean          default("false")
#

require 'rails_helper'

RSpec.describe Deal, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
