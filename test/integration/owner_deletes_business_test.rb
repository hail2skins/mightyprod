require "test_helper"

class OwnerDeletesBusinessTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  test "owner soft deletes a business" do
    within(".business") do
      click_link "Delete"
    end
    
    assert_equal owner_path(owner), current_path
    check_content "You have deleted this registered business."
  end
end
