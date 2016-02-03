require "test_helper"

class BusinessCreatesPackagesTest < ActionDispatch::IntegrationTest
  def setup
    package_test_login
  end
  
  def teardown
    click_link "Logout"
  end
  
  def microderm
    services(:third_service)
  end
  
  def facial
    services(:fourth_service)
  end
  
  def package_business
    businesses(:package_test_business)
  end
  
  def package_owner
    owners(:package_test_owner)
  end
  
  def main_facial
    services(:second_service)
  end
  
  test "create first package for a business" do
    refute page.has_content?("Packages -"), "Packages should not exist yet, but does."
    click_link "Add new package"
    
    assert_equal new_business_package_path(package_business), current_path
    assert_title "Add new package"
    check_content "Build your special package",
                  "Package Name",
                  "Description",
                  "Number of visits in package?",
                  "Service provided in this package",
                  "#{microderm.name}",
                  "#{facial.name}",
                  "Price"
    check_links "Back to business page"
    find_field "Package Name"
    find_field "Description"
    find_field "Number of visits in package?"
    find_field "Price"
    assert page.has_no_checked_field?("#{microderm.name}"), 
                                      "Field -- #{microderm.name} is checked and should not be"
    assert page.has_no_checked_field?("#{facial.name}"), 
                                      "Field -- #{facial.name} is checked and should not be"  
    fill_in "Package Name", with: "Sexy Back"
    fill_in "Number of visits in package?", with: 4
    choose microderm.name
    fill_in "Price", with: 100
    click_button "Create Package"
    
    assert_equal owner_business_path(package_owner, package_business), current_path
    refute page.has_content?("Add new package"), "Add new package exists and should not."
    check_links "Packages - 1"
  end
  
  test "fail to create a package" do
    click_link "Add new package"
    
    click_button "Create Package"
    check_content "Please review the problems below:",
                  "Name Package Name can't be blank.",
                  "Count Number of visits in package can't be blank.",
                  "Amount can't be blank"
  end
  
  test "create a third package for an existing business" do
    click_link "Logout"
    login
    click_link "Packages - 2"
    
    assert_equal business_packages_path(business), current_path
    click_link "Create another package"
    
    assert_equal new_business_package_path(business), current_path
    fill_in "Package Name", with: "Second Pack"
    fill_in "Number of visits in package?", with: 5
    choose main_facial.name
    fill_in "Price", with: 200
    click_button "Create Package"
    
    assert_equal owner_business_path(owner, business), current_path
    refute page.has_link?("Packages - 2"), "Packages - 1 link should be gone now."
    check_links "Packages - 3"
  end
  

end