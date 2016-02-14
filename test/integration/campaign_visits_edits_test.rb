require "test_helper"

class CampaignVisitsEditsTest < ActionDispatch::IntegrationTest
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
  
  def service_one
    services(:campaign_visits_read_service_one)
  end
  
  test "edit a campaign visit to make it a normal visit from the campaign visits index" do
    check_content "Campaign Visits: 2"
    visit campaign_visits_business_path(test_business)
    check_content "$90.00"
    #custom method from selectors.rb
    find(:linkhref, edit_customer_visit_path(customer_one, visit_one)).click
    
    assert_equal edit_customer_visit_path(customer_one, visit_one), current_path
    assert page.has_checked_field?(campaign.name)
    uncheck campaign.name
    click_button "Update Visit"
    
    assert_equal owner_business_path(test_owner, test_business), current_path
    check_content "Campaign Visits: 1",
                  "Visit successfully edited.",
                  "$100.00"
  end
  
  test "edit a campaign visit to make it a normal visit from customer campaign visits index" do
    check_content "Campaign Visits: 2"
    visit customer_campaign_visits_customer_path(customer_one)
    check_content "$90.00"
    click_link "Edit"
    
    assert_equal edit_customer_visit_path(customer_one, visit_one), current_path
    uncheck campaign.name
    click_button "Update Visit"
    
    check_content "Campaign Visits: 1",
                  "Visit successfully edited.",
                  "$100.00"
  end
  
  test "edit a normal visit to become a campaign visit" do
    check_content "Campaign Visits: 2"
    visit new_customer_visit_path(customer_one)
    
    fill_in "Visit notes", with: "This may actually work."
    fill_in "visit_date_of_visit", with: "02/01/2015"
    check service_one.name
    click_button "Create Visit"
    
    check_content "$190.00"
    click_link customer_one.first_name
    
    click_link "Total Visits"
    
    all("a", text: "Edit")[1].click
    
    assert page.has_no_checked_field?(campaign.name)
    check campaign.name
    click_button "Update Visit"
    
    check_content "Campaign Visits: 3",
                  "$180.00",
                  "Visit successfully edited."
    
  end
  
end