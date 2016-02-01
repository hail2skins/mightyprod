require "test_helper"

class BusinessDeletesCustomersTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  test "deleting customer from customer index page" do
    click_link "Customers:"

    within(".table") do
      first(:link, "Delete").click
    end
    
    #Takes you back to customer index page
    assert_equal business_customers_path(business), current_path
    check_content "Customer has been deleted."
    refute page.has_content? "Mills"
  end
  
  test "deleting customer from customer show page" do
    click_link "Logout"
    login
    
    click_link "Customers:"
    
    within(".table") do
      click_link "Art"
    end
    
    click_link "Delete Customer"
    
    #Different from above, this now takes you back to owner_business_path
    assert_equal owner_business_path(owner, business), current_path
    check_content "Customers: 3",
                  "Customer has been deleted."
  end
  
  test "deleting customer from owner business show page" do
    click_link "Logout"
    login

    within(".table") do
      first(:link, "Delete").click
    end
    
    assert_equal owner_business_path(owner, business), current_path
    check_content "Customers: 3",
                  "Customer has been deleted."
  end
  
end