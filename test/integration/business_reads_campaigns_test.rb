require "test_helper"

class BusinessReadsCampaignsTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  test "view all active campaigns" do
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
  end

  test "view all completed campaigns" do
    
  end
  
  test "view all campaigns" do
    
  end
  
  test "view one active campaign" do
    
  end
  
  test "view one completed campaign" do
  
  end

  
end