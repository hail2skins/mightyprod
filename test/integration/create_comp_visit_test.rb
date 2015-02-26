require "test_helper"

class CreateCompVisitTest < ActionDispatch::IntegrationTest
  def setup
    login
    #confirm has spent $200 as the fixtures require
    check_content "$200.00"
    click_link "1"
    
    fill_in "visit_date_of_visit", with: "02/10/2015"
    check service_one.name
    check service_two.name
  end
  
  def teardown
    find("header").click_link("Logout")
  end
  
  
  test "create a comp visit where you charge someone less" do
    check_content "Did you discount this visit?",
                  "If so, check the box below and type in the total amount you charged for this visit.",
                  "As an example, if you normally charge $100.00 for a service, but only charged this customer $75.00, check the box and type in $75.00.",
                  "When you click the Create Visit button, we'll do the math for you.",
                  "Check this ONLY if you wish to give a discount",
                  "Total charged for this visit?"
                  
    assert page.has_no_checked_field?("Check this ONLY if you wish to give a discount"), "Field -- Check this ONLY if you wish to give a discount is checked."
    
    find_field "Total charged for this visit?"
    
    check "Check this ONLY if you wish to give a discount"
    
    fill_in "Total charged for this visit?", with: "100"
    
    click_button "Create Visit"

    check_content "$300"
    
    refute page.has_content?("$400"), "Content -- $400 shows for total when it should be $300."
    
    click_link "Art"
    
    check_content "Amount Spent: $300.00"
    
    #will check visibility of total comps to customer and to business on comp_show_test.rb
 
  end

  test "fail to create a comp checking the box but leaving amount empty" do
    check "Check this ONLY if you wish to give a discount"
    
    click_button "Create Visit"
    
    check_content "You checked the box but did not enter the total visit amount.  No discount created on this visit.",
                  "$400.00"
  end

  test "fail to create a comp checking the box and filling out too much for amount" do
    check "Check this ONLY if you wish to give a discount"
    
    fill_in "Total charged for this visit?", with: "7000"
    
    click_button "Create Visit"
    
    check_content "You entered more for the discount than the visit cost.   No discounted created.",
                  "$400.00"
    
  end

end
