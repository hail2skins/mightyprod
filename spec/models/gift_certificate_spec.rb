# == Schema Information
#
# Table name: gift_certificates
#
#  id                 :integer          not null, primary key
#  customer_id        :integer
#  active             :boolean          default("true")
#  date_redeemed      :date
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  business_id        :integer
#  certificate_number :integer
#  initial_comment    :text
#  redemption_comment :text
#

require 'rails_helper'

RSpec.describe GiftCertificate, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
