# == Schema Information
#
# Table name: businesses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  owner_id    :integer
#  selected    :boolean          default(FALSE)
#


# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :business do
  	owner
  	sequence(:name) { |n| "My Big Business #{n}" }
    description "My amazing business"
  end
end

