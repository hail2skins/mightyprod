require "test_helper"

class BusinessDeletesCampaignsTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  def first_active_campaign
    campaigns(:first_active_campaign)
  end
  
  def first_completed_campaign
    campaigns(:first_completed_campaign)
  end
  
  test "delete campaign from active index" do
    visit active_campaigns_business_path(business)
    first(:link, "Delete").click
    
    assert_equal owner_business_path(owner, business), current_path
    check_content "Active Campaigns - 1",
                  "Campaign deleted."
  end
  
  test "delete campaign from completed index" do
    visit completed_campaigns_business_path(business)
    first(:link, "Delete").click
    
    assert_equal owner_business_path(owner, business), current_path
    check_content "Completed Campaigns - 1",
                  "Campaign deleted."
  end
  
  test "delete campaign from all index" do
    visit business_campaigns_path(business)
    first(:link, "Delete").click
    
    assert_equal owner_business_path(owner, business), current_path
    check_content "Active Campaigns - 1",
                  "Campaign deleted."
  end  
  
  test "delete campaign from show page" do
    visit business_campaign_path(business, first_active_campaign)
    click_link "Delete this campaign"
    
    assert_equal owner_business_path(owner, business), current_path
    check_content "Active Campaigns - 1",
                  "Campaign deleted."
  end    
  
end