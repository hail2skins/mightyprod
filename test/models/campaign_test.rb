require "test_helper"

class CampaignTest < ActiveSupport::TestCase
  def campaign
    @campaign ||= Campaign.new
  end

  def test_valid
    assert campaign.valid?
  end
end
