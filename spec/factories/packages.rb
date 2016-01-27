# == Schema Information
#
# Table name: packages
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  count       :integer
#  business_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  service_id  :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :package do
    name "MyString"
    description "MyText"
    count 1
    date_purchased "2014-10-30"
    business nil
  end
end
