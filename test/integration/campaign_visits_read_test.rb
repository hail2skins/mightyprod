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
                    "$#{appointment_one.amount}0"
      check_links campaign.name,
                  customer_one.name,
                  visit_one.date_of_visit.strftime("%m/%d/%Y")
    end
  end
  
  test "confirm links from campaign visits index page" do
    visit campaign_visits_business_path(test_business)
    click_link "Return to main business page"
    
    assert_equal owner_business_path(test_owner, test_business), current_path
    visit campaign_visits_business_path(test_business)
    first(:link, campaign.name).click
    
    assert_equal business_campaign_path(test_business, campaign), current_path
    visit campaign_visits_business_path(test_business)
    click_link customer_one.name
    
    assert_equal business_customer_path(test_business, customer_one), current_path
    visit campaign_visits_business_path(test_business)
    click_link visit_one.date_of_visit.strftime("%m/%d/%Y")
    
    assert_equal customer_visit_path(customer_one, visit_one), current_path

  end
  
  test "view specific campaign visit from campaign visits index" do
    visit campaign_visits_business_path(test_business)
    click_link visit_one.date_of_visit.strftime("%m/%d/%Y")
    
    assert_equal customer_visit_path(customer_one, visit_one), current_path
    check_content "Campaign Visit",
                  "Percentage Off:",
                  campaign.name,
                  "#{campaign.percentage}.00%"
    
  end
  
  test "view campaign visits total count from customer show page" do
    visit business_customer_path(test_business, customer_one)
    check_content "Total Campaign Visits: #{customer_one.visits.joins(:campaigns).count.to_i}"
    check_links "Total Campaign Visits:"
  end
  
  test "view index of customers campaign visits from customer page" do
    visit business_customer_path(test_business, customer_one)
    click_link "Total Campaign Visits:"
    
    assert_equal customer_campaign_visits_customer_path(customer_one), current_path
    assert_title "Customer Campaign Visits"
    assert_css "table"
    check_content "#{customer_one.name} Visits During Marketing Campaigns"
    check_links "Return to customer page"
    within(".table") do
      check_content "Campaign Title",
                    "Percentage Off",
                    "Total Spent",
                    "Visit Date",
                    campaign.name,
                    campaign.percentage
      check_links campaign.name,
                  visit_one.date_of_visit.strftime("%m/%d/%Y")
    end    
  end
  
  test "click links on customer campaign visits index page" do
    visit customer_campaign_visits_customer_path(customer_one)
    click_link "Return to main business page"
    
    assert_equal owner_business_path(test_owner, test_business), current_path
    visit customer_campaign_visits_customer_path(customer_one)
    click_link campaign.name
    
    assert_equal business_campaign_path(test_business, campaign), current_path
    visit customer_campaign_visits_customer_path(customer_one)
    click_link "Return to customer page"
    
    assert_equal business_customer_path(test_business, customer_one), current_path
    visit customer_campaign_visits_customer_path(customer_one)
    click_link visit_one.date_of_visit.strftime("%m/%d/%Y")
    
    assert_equal customer_visit_path(customer_one, visit_one), current_path    
    
  end
  

end