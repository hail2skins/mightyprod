require "test_helper"

class EditVisitTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    find("header").click_link("Logout")
  end
  
  test "edit visit from customer profile page" do
    click_link "Art"
    
    #first confirm you can edit this from the Last Visit link
    click_link visit_one.date_of_visit.strftime("%m/%d/%Y")
    
    #confirming current info about this visit as it will be changing.
    check_content "Art's very first visit.",
                  visit_one.date_of_visit.strftime("%m/%d/%Y"),
                  "Microderm",
                  "Facial",
                  "$200"
    
    click_link "Edit this visit"
    assert_equal edit_customer_visit_path(customer, visit_one), current_path, "Expected to be at the edit visit page but at #{current_path}."
    assert page.has_title?("Edit this visit"), "Title -- Edit this visit not available."
    #assure form content expected exists
    check_content "Visit notes",
                  "Date of visit",
                  "Service(s) provided on this visit"
        
    #now confirm fields are filled with expected data.  Date not visible.   Following up.
    check_content "Art's very first visit.",
                  "#{service_one.name}",
                  "#{service_two.name}"
                  
    assert page.has_checked_field?(service_one.name)
    assert page.has_checked_field?(service_two.name)
    
    fill_in "Visit notes", with: "Art's first visit was great."
    fill_in "visit_date_of_visit", with: "2015/02/25"#done because of weirdness with this field
    uncheck service_two.name
    click_button "Update Visit"
    
    #Friendly visit edited note:
    check_content "Visit successfully edited"
    
    click_link "Art"

    click_link "02/25/2015"
    #now check edited content is here.
    check_content "Art's first visit was great.",
                  "02/25/2015",
                  "Microderm",
                  "$125"
                  
    #now let's go back a bit and see the visit index and edit from there
    click_link "Return to customer profile page"
    
    click_link "Total Visits"
    
    click_link "Edit"
    
    assert_equal edit_customer_visit_path(customer, visit_one), current_path, "Expected to be at the edit page for this visit but at #{current_path}."
    
    #now the my visit history button
    click_link "Return to customer profile page"
    click_link "My Visit History"
    click_link "Edit"
    assert_equal edit_customer_visit_path(customer, visit_one), current_path, "Expected to be at the edit page for this visit but at #{current_path}."    
  end

  test "edit a visit from business page index link" do
    click_link "Total Customer Visits: #{business.visits.count}"
    click_link visit_one.visit_notes
    click_link "Edit this visit"
    assert_equal edit_customer_visit_path(customer, visit_one), current_path, "Expected to be at the edit page for this visit but at #{current_path}."    
  end
  
  test "fail to edit a business by failing to fill out required fields" do
    click_link "Total Customer Visits: #{business.visits.count}"
    click_link visit_one.visit_notes
    click_link "Edit this visit"
    
    fill_in "visit_date_of_visit", with: ""
    uncheck service_one.name
    uncheck service_two.name
    
    click_button "Update Visit"
    
    check_content "Please review the problems below:",
                  "can't be blank",
                  "can't be blank"
  end

  
end
