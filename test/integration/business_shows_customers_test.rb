require "test_helper"

class BusinessShowsCustomersTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  test "view all business customers" do
    click_link "Customers:"
    
    assert_equal business_customers_path(business), current_path
    assert_title "#{business.name} Customers List"
    assert_css "table"
    within(".table") do
      page.has_css? "customers"
      check_content "First Name",
                    "Last Name",
                    "Email",
                    "Phone",
                    "Visits",
                    "Edit",
                    "Delete"
      check_links "Art",
                  "David",
                  "Kathy",
                  "Rose",
                  "Edit",
                  "Delete"
    end
    check_content "Complete Customer List for #{business.name}",
                  "Find customer"
    check_links "New Customer",
                "Back"
    click_link "Back"
    
    assert_equal owner_business_path(owner, business), current_path
  end
  
  test "view a specific customer" do
    click_link "Customers:"
    
    click_link "Art"
    
    assert_equal business_customer_path(business, 
                                        business.customers.find_by(first_name: "Art")), 
                                        current_path
    assert_title "Art Mills"
    check_content "Art Mills Customer Information",
                  "Name:",
                  "Art Mills",
                  "Email:",
                  "Last Visit:",
                  "Total Amount Discounted:",
                  "Amount Spent:",
                  "Phone Numbers:"
    check_links "Return to main business page",
                "Edit Customer",
                "Delete Customer",
                "New visit for Art Mills",
                "Total Visits",
                "Purchase a package?",
                "My Visit History"
    
  end
  
end