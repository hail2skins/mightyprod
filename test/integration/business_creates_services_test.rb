require "test_helper"

class BusinessCreatesServicesTest < ActionDispatch::IntegrationTest
  def setup
    service_test_login
  end
  
  def teardown
    click_link "Logout"
  end
  
  def service_test_business
    businesses(:service_test_business)
  end
  
  def service_test_owner
    owners(:service_test_owner)
  end
  
  test "successfully creates a service" do
    check_content "Services Information",
                  "Please tell us what types of services your business provides."
    check_links "Add a service your business provides now!"
    
    click_link "Add a service your business provides now!"
    
    assert_equal new_business_service_path(service_test_business), current_path
    assert_title "Add a service"
    
    fill_in "Service name", with: "Microderm"
    fill_in "Description", with: "Full service Microderm"
    fill_in "Price", with: "125"
    click_button "Create Service"
    
    assert_equal owner_business_path(service_test_owner, service_test_business), current_path
    check_content "New service created.",
                  "Number of services: 1"
                  
    check_links "Number of services:"
                  
    refute page.has_content? "Please tell us what types of services your business provides."
 end
 
 test "fails to create a service" do
   click_link "Add a service your business provides now!"
    fill_in "Service name", with: ""
    fill_in "Price", with: ""
    click_button "Create Service"
    
  check_content "Please review the problems below:",
                "Name can't be blank",
                "Amount can't be blank"
 end
 
 test "create another service" do
   #logout service_test_owner
   click_link "Logout"
   #login as main test owner
   login
   
   check_content "Number of services: 2"
   
   within(".services") do
     click_link "Add"
   end
   
   fill_in "Service name", with: "Third Service"
   fill_in "Price", with: "50"
   click_button "Create Service"
   
   assert_equal owner_business_path(owner, business), current_path
   check_content "Number of services: 3"
 end
end
