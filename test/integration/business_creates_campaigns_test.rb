require "test_helper"

class BusinessCreatesCampaignsTest < ActionDispatch::IntegrationTest
  def setup
    campaign_test_login
  end
  
  def teardown
    click_link "Logout"
  end
  
  def campaign_owner
    owners(:campaign_test_owner)
  end
  
  def campaign_business
    businesses(:campaign_test_business)
  end
  
  test "business successfully creates first campaign" do
    assert_equal owner_business_path(campaign_owner, campaign_business), current_path
    check_content "Create First Campaign"
    check_links "Create First Campaign"
    click_link "Create First Campaign"
    
    assert_equal new_business_campaign_path(campaign_business), current_path
    assert_title "Customer Marketing Campaign"
    check_content "Customer Marketing Campaign"
    check_links "Back to business page"
    find_field "Campaign Title"
    find_field "Description"
    find_field "Percentage Off"
    find_field "Start date"
    find_field "Expiration date"
    fill_in "Campaign Title", with: "First Campaign"
    fill_in "Description", with: "Very first campaign."
    fill_in "Percentage Off", with: 20
    fill_in "Start date", with: "#{Time.now}"
    fill_in "Expiration date", with: "#{Time.now + 10.days}"
    click_button "Create Campaign"
    
    assert_equal owner_business_path(campaign_owner, campaign_business), current_path
    check_content "Campaign Created."
    check_links "Active Campaigns - 1",
                "Completed Campaigns - 0"
    refute page.has_content?("Create First Campaign"), "Create First Campaign exists and should not."
  end

end