require "test_helper"

class CreateVisitTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  def owner
    owners(:owner)
  end
  
  test "create visit with one service from main business show page" do
    #visit created through fixture will show the following:
    check_links("Total Customer Visits: #{business.visits.count}")
                
    #and this
   
    check_content "Total Customer Visits: #{business.visits.count}"
    fill_in "Find customer", with: "David"
    click_button "Find"
    click_link "0"
    
    assert_equal new_customer_visit_path(customer1), current_path,
                "Expected to be at David's new visit form, but at #{current_path}."
                
    assert page.has_title?("Add a visit for #{customer1.name}"), "Title -- Add a visit for #{customer1.name} not available."
    
    #check new visit page for expected content
    check_content("New visit for #{customer1.name}",
                  "Visit notes",
                  "Date of visit",
                  "Service(s) provided on this visit",
                  "#{service_one.name}",
                  "#{service_two.name}")
                  
    #check expected links on the page
    check_links("Back to main business page",
                "Return to customer profile view")
                
    find_field "Visit notes"
   
    find_field "visit_date_of_visit"
   
    assert page.has_no_checked_field?("#{service_one.name}"), "Field -- #{service_one.name} is checked but should not be."
                
    assert page.has_no_checked_field?("#{service_two.name}"), "Field -- #{service_two.name} is checked but should not be."
    
    fill_in "Visit notes", with: "This may actually work."
    
    fill_in "visit_date_of_visit", with: "02/01/2015"
    
    check service_one.name
    
    click_button "Create Visit"
    
    assert_equal owner_business_path(owner, business), current_path, "Expected to be at main business profile page but at #{current_path}."
    
    #assure new content is visible
    check_content("Visit added for #{customer1.name}",
                  "Total Customer Visits: #{business.visits.count}",
                  "$125.00")

    assert page.has_link?("1", count: 2), "Link - 1 should exist twice but does not."
    
    #created.  will check all locations for this visit in the show_visit_test.rb
    
  end
  
  test "fail to create a second visit for the same date and customer" do
    click_link customer.first_name
    
    click_link "New visit for #{customer.name}"
    
    fill_in "Visit notes", with: "This may actually work."
    fill_in "visit_date_of_visit", with: "#{Time.now}"
    check service_one.name
    click_button "Create Visit"
    
    check_content "Please review the problems below:",
                  "Date of visit has already been taken"
  end
  
  test "create visit with two services from main business page" do
    
    #confirm two accounts have spent $200 so far
    assert page.has_content?("$200.00", count: 2), "Content - $200.00 should exist twice but does not."
    fill_in "Find customer", with: "David"
    click_button "Find"
    click_link "0"
    
    fill_in "Visit notes", with: "Whatever bro."
    
    fill_in "visit_date_of_visit", with: "02/03/2015"
    
    check service_one.name
    check service_two.name
    
    click_button "Create Visit"
    #Now David is in the $200 club.
    assert page.has_content?("$200.00", count: 3), "Content - $200.00 should exist three times but does not."
    
  end
  
  test "fail to create a visit by not filling in both required fields" do
    #date of visit and services are required.
    fill_in "Find customer", with: "David"
    click_button "Find"
    
    click_link "0"
    
    click_button "Create Visit"
    
    check_content("Please review the problems below:")
    
    assert page.has_content?("can't be blank", count: 2), "Content -- can't be blank should exist twice but does not."
    
  end
  
  test "fail to create a visit by not filling in date required field" do
    fill_in "Find customer", with: "David"
    click_button "Find"
    click_link "0"
    
    check service_one.name 
    
    click_button "Create Visit"
    
    check_content("Please review the problems below:",
                  "can't be blank")
                  
  end
  
  test "fail to create a visit by not checking service for visit" do
   fill_in "Find customer", with: "David"
   click_button "Find"
   click_link "0"
   
   fill_in "visit_date_of_visit", with: "02/01/2015"
   
   click_button "Create Visit"
    
   check_content("Please review the problems below:",
                 "can't be blank")
                  
  end
  
  test "confirm you get to new visit page through customer show page" do
    fill_in "Find customer", with: "David"
    click_button "Find"
    click_link "David"
    
    click_link "New visit for #{customer1.name}"
    
    assert_equal new_customer_visit_path(customer1), current_path, "Expected to be at new visit form for David but at #Pcurrent_path}."
  end



end