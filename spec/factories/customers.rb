# == Schema Information
#
# Table name: customers
#
#  id          :integer          not null, primary key
#  first_name  :string(255)
#  middle_name :string(255)
#  last_name   :string(255)
#  referred_by :string(255)
#  business_id :integer
#  email       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  deleted_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    first_name "MyString"
    middle_name "MyString"
    last_name "MyString"
    phone 1
    referred_by "MyString"
    business nil
  end
end
