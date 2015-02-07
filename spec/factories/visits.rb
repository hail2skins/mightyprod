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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :visit do
    visit_notes "MyText"
    date_of_visit "2014-10-24"
    customer nil
  end
end
