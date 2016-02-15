require "test_helper"

class CampaignVisitsDeletesTest < ActionDispatch::IntegrationTest
  def setup
    campaign_visits_read_test_login
  end
  
  def teardown
    click_link "Logout"
  end
  
  def test_owner
    owners(:campaign_visits_read_test_owner)
  end
  
  def test_business
    businesses(:campaign_visits_read_test_business)
  end
  
  def campaign
    campaigns(:campaign_visits_read_active_campaign)
  end
  
  def customer_one
    customers(:campaign_visits_read_customer_one)
  end
  
  test "delete campaign from campaign visits index" do
    visit campaign_visits_business_path(test_business)
    first(:link, "Delete").click
    
    check_content "Visit deleted."
    
    visit owner_business_path(test_owner, test_business)
    check_content "Campaign Visits: 1"
  end
  
  test "delete campaign from customer campaign visits index" do
    visit customer_campaign_visits_customer_path(customer_one)
    first(:link, "Delete").click
    
    assert_equal business_customer_path(test_business, customer_one), current_path
    check_content "Visit deleted."
    
    visit owner_business_path(test_owner, test_business)
    check_content "Campaign Visits: 1"
  end  
  
end