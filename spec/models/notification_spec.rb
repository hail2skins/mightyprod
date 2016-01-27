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

require 'rails_helper'

RSpec.describe Notification, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
