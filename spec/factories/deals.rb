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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :deal do
    customer nil
    date_purchased "2014-11-11"
    date_completed "2014-11-11"
    used_count 1
  end
end
