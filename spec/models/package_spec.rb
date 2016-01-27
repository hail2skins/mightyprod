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

require 'rails_helper'

RSpec.describe Package, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
