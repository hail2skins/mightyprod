require "test_helper"

class OwnerShowsBusinessTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  test "owner with one business logs in to see that business" do
    assert_equal owner_business_path(owner, business), current_path
    
    click_link "Home"
    click_link "Awesome Business"
    
    assert_equal owner_business_path(owner, business), current_path
  end
  
  test "owner with multiple businesses selects from owner profile page on login" do
    click_link "Home"
    within(".business") do
      click_link "Add"
    end
    
    fill_in "Business name", with: "Another Awesome Business"
    click_button "Submit my business information"
    click_link "Logout"
    
    click_link "Login"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "password"
    click_button "Login"
    
    assert_equal owner_path(owner), current_path
    check_links "Awesome Business",
                "Another Awesome Business"
                
    click_link "Another Awesome Business"
    assert_equal owner_business_path(owner, owner.businesses.last), current_path
  end
end
