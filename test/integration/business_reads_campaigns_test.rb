require "test_helper"

class BusinessReadsCampaignsTest < ActionDispatch::IntegrationTest
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
  
  test "view all active campaigns from business show page" do
    check_links "Active Campaigns - 2"
    click_link "Active Campaigns - 2"
    
    assert_equal active_campaigns_business_path(business), current_path
    assert_title "Active Marketing Campaigns"
    check_content "Active Marketing Campaigns",
                  "See all campaigns",
                  "See completed campaigns",
                  "Return to main business page"
    check_links "See all campaigns",
                "See completed campaigns",
                "Return to main business page"
    assert_css "table"
    within(".table") do
      check_content "Campaign Title",
                    "Percentage Off",
                    "Start date",
                    "Expiration date",
                    "First Active Campaign",
                    "Second Active Campaign",
                    "#{Time.now.to_date.strftime("%m/%d/%Y")}",
                    "#{(Time.now + 10.days).to_date.strftime("%m/%d/%Y")}",
                    "25",
                    "#{(Time.now - 3.days).to_date.strftime("%m/%d/%Y")}",
                    "#{(Time.now + 20.days).to_date.strftime("%m/%d/%Y")}",
                    "30"
      check_links "First Active Campaign",
                  "Second Active Campaign"
    end
    click_link "Return to main business page"
    
    assert_equal owner_business_path(owner,business), current_path
  end

  test "view all completed campaigns from business show page" do
    check_links "Completed Campaigns - 2"
    click_link "Completed Campaigns - 2"

    assert_equal completed_campaigns_business_path(business), current_path
    assert_title "Completed Marketing Campaigns"
    check_content "Completed Marketing Campaigns",
                  "See all campaigns",
                  "See active campaigns",
                  "Return to main business page"
    check_links "See all campaigns",
                "See active campaigns",
                "Return to main business page"
    assert_css "table"
    within(".table") do
      check_content "Campaign Title",
                    "Percentage Off",
                    "Start date",
                    "Expiration date",
                    "First Completed Campaign",
                    "Second Completed Campaign",
                    "#{(Time.now - 100.days).to_date.strftime("%m/%d/%Y")}",
                    "#{(Time.now - 90.days).to_date.strftime("%m/%d/%Y")}",
                    "15",
                    "#{(Time.now - 50.days).to_date.strftime("%m/%d/%Y")}",
                    "#{(Time.now - 5.days).to_date.strftime("%m/%d/%Y")}",
                    "18"
      check_links "First Completed Campaign",
                  "Second Completed Campaign"
    end    
  end
  
  test "view completed campaigns from active campaigns" do
    click_link "Active Campaigns - 2"
    
    click_link "See completed campaigns"
    
    assert_equal completed_campaigns_business_path(business), current_path
  end
  
  test "view active campaigns from completed campaigns" do
    click_link "Completed Campaigns - 2"
    
    click_link "See active campaigns"
    
    assert_equal active_campaigns_business_path(business), current_path
  end
  
  test "view all campaigns from active campaigns" do
    click_link "Active Campaigns"
    
    click_link "See all campaigns"
    
    assert_equal business_campaigns_path(business), current_path
    assert_title "All Marketing Campaigns"
    check_content "All Marketing Campaigns"
    assert_css "table"
    within('.table') do
      check_content "Campaign Title",
                    "Percentage Off",
                    "Start date",
                    "Expiration date",
                    "First Completed Campaign",
                    "Second Completed Campaign",
                    "First Active Campaign",
                    "Second Active Campaign",
                    "#{(Time.now - 100.days).to_date.strftime("%m/%d/%Y")}",
                    "#{(Time.now - 90.days).to_date.strftime("%m/%d/%Y")}",
                    "15",
                    "#{(Time.now - 50.days).to_date.strftime("%m/%d/%Y")}",
                    "#{(Time.now - 5.days).to_date.strftime("%m/%d/%Y")}",
                    "18",
                    "#{Time.now.to_date.strftime("%m/%d/%Y")}",
                    "#{(Time.now + 10.days).to_date.strftime("%m/%d/%Y")}",
                    "25",
                    "#{(Time.now - 3.days).to_date.strftime("%m/%d/%Y")}",
                    "#{(Time.now + 20.days).to_date.strftime("%m/%d/%Y")}",
                    "30"
      check_links "First Completed Campaign",
                  "Second Completed Campaign",
                  "First Active Campaign",
                  "Second Active Campaign"
    end
    check_links "Return to main business page",
                "See active campaigns",
                "See completed campaigns"
  end
  
  test "click all links on index" do
    visit business_campaigns_path(business)
    click_link "See active campaigns"
    
    assert_equal active_campaigns_business_path(business), current_path
    visit business_campaigns_path(business)
    click_link "See completed campaigns"
    
    assert_equal completed_campaigns_business_path(business), current_path
    visit business_campaigns_path(business)
    click_link "Return to main business page"
    
    assert_equal owner_business_path(owner, business), current_path
  end  
  
  
  test "view all campaigns from completed campaigns" do
    click_link "Completed Campaigns - 2"
    
    click_link "See all campaigns"
    
    assert_equal business_campaigns_path(business), current_path
    
  end
  
  test "view one active campaign" do
    click_link "Active Campaigns - 2"
    
    click_link "First Active Campaign"
    
    assert_equal business_campaign_path(business, first_active_campaign), current_path
    assert_title "First Active Campaign"
    check_content "First Active Campaign"
    assert_css "table"
    within('.table') do
      check_content "Campaign Title: First Active Campaign",
                    "Description: First active campaign",
                    "Percentage Off: 25",
                    "Start date: #{first_active_campaign.start_date.to_date.strftime("%m/%d/%Y")}",
                    "Expiration date: #{first_active_campaign.expiration_date.to_date.strftime("%m/%d/%Y")}"

    end
  check_links "Return to main business page",
              "See all campaigns",
              "See active campaigns",
              "See completed campaigns"
  end

  test "click all links on show" do
    visit business_campaign_path(business, first_active_campaign)
    click_link "Return to main business page"
    
    assert_equal owner_business_path(owner, business), current_path
    visit business_campaign_path(business, first_active_campaign)
    click_link "See all campaigns"
    
    assert_equal business_campaigns_path(business), current_path
    visit business_campaign_path(business, first_active_campaign)
    click_link "See active campaigns"
    
    assert_equal active_campaigns_business_path(business), current_path
    visit business_campaign_path(business, first_active_campaign)
    click_link "See completed campaigns"
    
    assert_equal completed_campaigns_business_path(business), current_path

    
  end

  
  test "view one completed campaign" do
    click_link "Completed Campaigns - 2"
    
    click_link "First Completed Campaign"
    
    assert_equal business_campaign_path(business, first_completed_campaign), current_path
  end
  
  test "view one active campaign from index" do
    click_link "Active Campaigns - 2"
    
    click_link "First Active Campaign"
    
    assert_equal business_campaign_path(business, first_active_campaign), current_path
  end
 
  test "view one complete campaign from index" do
    click_link "Completed Campaigns - 2"
    
    click_link "First Completed Campaign"
    
    assert_equal business_campaign_path(business, first_completed_campaign), current_path
  end
  
  
end