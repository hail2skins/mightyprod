require "test_helper"

class BusinessUpdatesCampaignsTest < ActionDispatch::IntegrationTest
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
  
  test "update active campaign from active index" do
    click_link "Active Campaigns - 2"
    
    first(:link, "Edit").click
    
    assert_equal edit_business_campaign_path(business, first_active_campaign), current_path
    assert_title "Edit Marketing Campaign"
    check_content "Edit Marketing Campaign"
    fill_in "Campaign Title", with: "Edited Active Campaign"
    fill_in "Percentage Off", with: 2
    fill_in "Start date", with: "#{(Time.now - 1.days)}"
    click_button "Update Campaign"

    assert_equal owner_business_path(owner, business), current_path
    check_content "Marketing Campaign updated successfully."
    click_link "Active Campaigns - 2"
    
    refute page.has_content?("First Active Campaign"), "First Active Campaign exists and should not."
    refute page.has_content?("25"), "25 exists and should not."
    refute page.has_content?("#{Time.now.to_date.strftime("%m/%d/%Y")}"), "#{Time.now.to_date.strftime("%m/%d/%Y")} exists and should not."
    check_content "Edited Active Campaign",
                  "2",
                  "#{(Time.now - 1.days).to_date.strftime("%m/%d/%Y")}"
  end
  
  test "update active campaign so it is completed from show page" do
    visit active_campaigns_business_path(business)
    click_link "First Active Campaign"
    
    click_link "Edit this campaign"
    assert_equal edit_business_campaign_path(business, first_active_campaign), current_path
    fill_in "Expiration date", with: "#{(Time.now - 2.days)}"
    click_button "Update Campaign"
    
    check_content "Active Campaigns - 1",
                  "Completed Campaigns - 3"
  end
  
  test "update completed campaign so it is active" do
    visit completed_campaigns_business_path(business)
    click_link "First Completed Campaign"
    
    click_link "Edit this campaign"
    fill_in "Expiration date", with: "#{(Time.now + 2.days)}"
    click_button "Update Campaign"
    
    check_content "Active Campaigns - 3",
                  "Completed Campaigns - 1"
  end
  
  test "fail to update campaign due to required fields" do
    visit edit_business_campaign_path(business, first_active_campaign)
    fill_in "Campaign Title", with: ""
    fill_in "Percentage Off", with: ""
    fill_in "Start date", with: ""
    fill_in "Expiration date", with: ""
    click_button "Update Campaign"
    check_content "Please review the problems below:",
                  "Name can't be blank",
                  "Percentage can't be blank",
                  "Start date can't be blank",
                  "Expiration date can't be blank"
  end
  
end