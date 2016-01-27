# == Schema Information
#
# Table name: appointments
#
#  id         :integer          not null, primary key
#  service_id :integer
#  visit_id   :integer
#  amount     :decimal(8, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :appointment do
    service nil
visit nil
amount "9.99"
  end

end
