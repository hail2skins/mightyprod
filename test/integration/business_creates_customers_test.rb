require "test_helper"

class BusinessCreatesCustomersTest < ActionDispatch::IntegrationTest
  def setup
    customer_test_login
  end
  
  def teardown
    click_link "Logout"
  end
  
  def owner
    owners(:customer_test_owner)
  end
  
  def business
    businesses(:customer_test_business)
  end
  
  test "owner successfully creates first customer" do
    assert_equal owner_business_path(owner, business), current_path
    
    check_content "Customer Information",
                  "You have not yet added any customers.",
                  "Add a customer for your business now!"
    check_links "Add a customer for your business now!"
    click_link "Add a customer for your business now!"
    
    assert_equal new_business_customer_path(business), current_path
    assert_title "Create a customer"
    fill_in "First name", with: "Test"
    fill_in "Last name", with: "Customer"
    fill_in "Email", with: "test@test.com"
    fill_in "Phone Number", with: "5555555555"
    click_button "Create Customer"
    
    assert_equal owner_business_path(owner, business), current_path
    check_content "Customer added",
                  "Customers: 1"
    check_links "Customers:"
    refute page.has_content? "You have not yet added any customers."
    
  end
  
  test "fails to create a customer" do
    click_link "Add a customer for your business now!"
    
    click_button "Create Customer"
    check_content "Please review the problems below:",
                  "First name can't be blank",
                  "Last name can't be blank"
  
  end
  
  test "create another customer" do
    click_link "Logout"
    login
    
    check_content "Customers: 4"
    within(".customers") do
      click_link "Add"
    end
    
    fill_in "First name", with: "Fourth"
    fill_in "Last name", with: "Customer"
    click_button "Create Customer"
    
    check_content "Customers: 5"
  end
  
  
end