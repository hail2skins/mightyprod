require "test_helper"

class CampaignVisitsCreatesTest < ActionDispatch::IntegrationTest
  def setup
    campaign_visits_test_login
  end
  
  def teardown
    click_link "Logout"
  end
  
  def cv_owner
    owners(:campaign_visits_test_owner)
  end
  
  def cv_business
    businesses(:campaign_visits_test_business)
  end
  
  def cv_service_one
    services(:campaign_visits_service_one)
  end
  
  def cv_service_two
    services(:campaign_visits_service_two)
  end
  
  def cv_customer_one
    customers(:campaign_visits_customer_one)
  end
  
  def cv_customer_two
    customers(:campaign_visits_customer_two)
  end
  
  def cv_campaign
    campaigns(:campaign_visits_active_campaign)
  end
  
  test "create a campaign visit then confirm it took" do
    visit new_customer_visit_path(cv_customer_one)
    check_content "Currently Active Campaigns",
                  "First Active Campaign",
                  "Customer has not yet visited during this campaign"
    assert page.has_checked_field?(cv_campaign.name)
    fill_in "visit_date_of_visit", with: Time.now
    check cv_service_one.name
    click_button "Create Visit"
    
    visit new_customer_visit_path(cv_customer_one)
    check_content "Customer has already participated in this campaign."
    assert page.has_no_checked_field?(cv_campaign.name)
    
    
  end
end