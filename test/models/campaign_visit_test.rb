require "test_helper"

class CampaignVisitTest < ActiveSupport::TestCase
  def campaign_visit
    @campaign_visit ||= CampaignVisit.new
  end

  def test_valid
    assert campaign_visit.valid?
  end
end
