# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  subject     :string
#  body        :text
#  business_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :notification do
    subject "MyString"
body "MyText"
  end

end
