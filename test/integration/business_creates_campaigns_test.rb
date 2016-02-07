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
                "Completed Campaigns - 0",
                "Add a campaign"
    refute page.has_content?("Create First Campaign"), "Create First Campaign exists and should not."
  end
  
  test "business successfully creates multiple campaigns" do
    click_link "Create First Campaign"
    
    fill_in "Campaign Title", with: "First Campaign"
    fill_in "Description", with: "Very first campaign."
    fill_in "Percentage Off", with: 20
    fill_in "Start date", with: "#{Time.now}"
    fill_in "Expiration date", with: "#{Time.now + 10.days}"
    click_button "Create Campaign"
    
    click_link "Add a campaign"
    
    assert_equal new_business_campaign_path(campaign_business), current_path
    fill_in "Campaign Title", with: "Second Campaign"
    fill_in "Description", with: "Second campaign."
    fill_in "Percentage Off", with: 15
    fill_in "Start date", with: "#{Time.now - 3.days}"
    fill_in "Expiration date", with: "#{Time.now + 10.days}"
    click_button "Create Campaign"
    
    check_content "Active Campaigns - 2"
    check_links "Active Campaigns - 2"
    refute page.has_link?("Active Campaigns - 1"), "Link for Active Campaigns - 1 exists but should not."
  end
  
  test "when business has a completed campaign it shows as completed" do
    click_link "Create First Campaign"
    
    fill_in "Campaign Title", with: "First Campaign"
    fill_in "Description", with: "Very first campaign."
    fill_in "Percentage Off", with: 20
    fill_in "Start date", with: "#{Time.now - 10.days}"
    fill_in "Expiration date", with: "#{Time.now - 5.days}"
    click_button "Create Campaign"
    
    check_links "Active Campaigns - 0",
                "Completed Campaigns - 1"
  end
  
  test "business failes to create a campaign with invalid attributes" do
    click_link "Create First Campaign"
    
    fill_in "Campaign Title", with: ""
    fill_in "Percentage Off", with: ""
    fill_in "Start date", with: ""
    fill_in "Expiration date", with: ""
    click_button "Create Campaign"
    
    check_content "Please review the problems below:",
                  "Name can't be blank",
                  "Percentage can't be blank",
                  "Start date can't be blank",
                  "Expiration date can't be blank"
                  
  
  end

end