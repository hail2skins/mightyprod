require "test_helper"

class BusinessDeletesServicesTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  test "deleting services" do
    click_link "Number of services:"
    click_link "Microderm"
    click_link "Delete this service"
    
    assert_equal business_path(business), current_path
    refute page.has_content?("Number of services: 2"), "There are still two services."
    click_link "Number of services:"
    refute page.has_content?("Microderm"), "The Microderm service isn't deleted."
  end
end
