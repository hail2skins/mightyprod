require "test_helper"

class LogoutTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  test "log out of the site" do
    click_link "Logout"
    
    assert_equal root_path, current_path
    check_content "Signed out successfully."
    
  end
end
