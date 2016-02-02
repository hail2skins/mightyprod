require "test_helper"

class BusinessEditsCustomersTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  test "edit customer from main business page" do
    click_link "#{customer.first_name}"
    
    click_link "Edit Customer"
    
    assert_equal edit_business_customer_path(business, customer), current_path
    fill_in "First name", with: "Arthur"
    click_button "Update Customer"
    
    assert_equal owner_business_path(owner, business), current_path
    check_content "Arthur"
    check_links "Arthur"
    
    #now test edit directly
    within('.table') do
      first(:link, "Edit").click
    end
    
    fill_in "Last name", with: "Beautiful"
    click_button "Update Customer"
    
    assert_equal owner_business_path(owner, business), current_path
    check_content "Beautiful"
  end
  
  test "fail to edit a customer from main business page" do
    click_link "#{customer.first_name}"
    
    click_link "Edit Customer"
    
    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    click_button "Update Customer"
    check_content "Please review the problems below:",
                  "First name can't be blank",
                  "Last name can't be blank"
  end
  
  test "edit customer from customer index" do
    click_link "Customers:"
    
    refute page.has_link?("Arthur"), "Link for Arthur exists and should not."
    assert_equal business_customers_path(business), current_path
    click_link "#{customer.first_name}"
    
    click_link "Edit Customer"
    
    fill_in "First name", with: "Arthur"
    click_button "Update Customer"
    
    assert_equal owner_business_path(owner, business), current_path
    check_links "Arthur"
    
    refute page.has_content?("Beautiful"), "Page should not have the word Beautiful, but does"
    click_link "Customers:"
    
    #now test from edit link directly
    within('.table') do
      first(:link, "Edit").click
    end
    
    fill_in "Last name", with: "Beautiful"
    click_button "Update Customer"
    
    check_content "Beautiful"
  end
  
end