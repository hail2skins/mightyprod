require "test_helper"

class CampaignVisitsReadsTest < ActionDispatch::IntegrationTest
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
  
  def visit_one
    visits(:campaign_visits_read_visit_one)
  end
  
  def appointment_one
    appointments(:campaign_visits_read_customer_one)
  end
  
  test "show index of campaign visits from main business page" do
    check_content "Campaign Visits"
    check_links "Campaign Visits"
    click_link "Campaign Visits"
    
    assert_equal campaign_visits_business_path(test_business), current_path
    assert_title "Campaign Visits"
    assert_css "table"
    check_content "Visits During Marketing Campaigns"
    check_links "Return to main business page"
    within(".table") do
      check_content "Campaign Title",
                    "Percentage Off",
                    "Total Spent",
                    "Customer",
                    "Visit Date",
                    "10",
                    appointment_one.amount
      check_links campaign.name,
                  customer_one.name,
                  visit_one.date_of_visit.strftime("%m/%d/%Y")
    end
    
    
    
  end
  
  test "view specific campaign visit from campaign visits index" do
    
  end
  
  test "view index of customers campaign visits from customer page" do
    
  end
  
  test "view specific customer campaign visit from customer campaign visits index" do
    
  end
  
  
end