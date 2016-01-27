require "test_helper"

class LoginTest < ActionDispatch::IntegrationTest
  def setup
    visit login_path
  end
  
  def login_owner
    owners(:login_owner)
  end

  test "login with valid credentials" do
 
    assert_equal login_path, current_path, "Expected to be at the login page but at #{current_path}."
    
    fill_in "Email", with: "login@owner.com"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal owner_path(login_owner), current_path, "Expected to be at the owner profile page, but at #{current_path}."
    check_content "Signed in successfully."
    click_link "Logout"
  end
  
  test "login with invalid credentials" do

    click_button "Login"
    
    assert_equal "/owners/sign_in", current_path
    check_content "Invalid email or password"

  end
end

