require "test_helper"

class BusinessReadsServicesTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  test "view all business services" do
    click_link "Number of services:"
    
    assert_equal business_services_path(business), current_path
    assert_title "Services for Awesome Business"
    assert_css "table"
    within(".table") do
      page.has_css? "services"
    end
    
    check_content "Services for Awesome Business",
                  "Service name",
                  "Price",
                  "$125.00",
                  "$75.00"
                  
    check_links "Microderm",
                "Facial",
                "New Service", 
                "Return to main business page"
                
    click_link "Return to main business page"
    
    assert_equal owner_business_path(owner, business), current_path
 end

  test "view a specific service" do
    click_link "Number of services:"
    click_link "Microderm"
    
    assert_equal business_service_path(business, business.services.find_by(name: "Microderm")), current_path
    assert_title "Microderm service details"
    check_content "Microderm service details",
                  "Service name: Microderm",
                  "Description: Making a pretty face",
                  "Price: $125.00"
                  
    check_links "New Service",
                "Back to service index",
                "Back to main business page"
                
    click_link "Back to service index"
    
    assert_equal business_services_path(business), current_path
  end

end
 
