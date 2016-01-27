require "test_helper"

class BusinessUpdatesServicesTest < ActionDispatch::IntegrationTest
  def setup
    login
    click_link "Number of services:"
  end
  
  def teardown
    click_link "Logout"
  end
  
  test "updating services from service index" do
    click_link "Microderm"
    check_content "Microderm",
                  "Making a pretty face",
                  "$125.00"
    check_links "Edit this service"
    click_link "Edit this service"
    
    assert_equal edit_business_service_path(business, service_one), current_path

    assert_field "Service name"
    assert_field "Description"
    assert_field "Price"
    
    fill_in "Service name", with: "Abrasion"
    fill_in "Description", with: "The prettiest face there is."
    fill_in "Price", with: "130"
    click_button "Update Service"
    
    assert_equal owner_business_path(owner, business), current_path
    click_link "Number of services:"
    click_link "Abrasion"
    check_content "Abrasion",
                  "The prettiest face there is.",
                  "$130.00"
  
    refute page.has_content?("Microderm"), "Microderm is still available."
    refute page.has_content?("Making a pretty face"), "Making a pretty face is still available."
    refute page.has_content?("$125.00"), "$125.00 is still available."
  end
 
  test "updating services with invalid information" do
    click_link "Microderm"  
    click_link "Edit this service"
    fill_in "Service name", with: ""
    fill_in "Description", with: ""
    fill_in "Price", with: ""
    click_button "Update Service"
   
    check_content "Please review the problems below:",
                  "Name can't be blank",
                  "Amount can't be blank"
 end 
   
end
