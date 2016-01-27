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

FactoryGirl.define do
  factory :gift_certificate do
    customer nil
active false
  end

end
