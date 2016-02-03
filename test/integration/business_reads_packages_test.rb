require "test_helper"

class BusinessReadsPackagesTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  def package_one
    packages(:single_service_package)
  end
  
  def package_two
    packages(:second_single_service_package)
  end
    
  
  
  
  test "view the package index" do
    click_link "Packages - 2"
    
    assert_equal business_packages_path(business), current_path
    assert_title "Package list for #{business.name}"
    assert_css "table"
    check_content "Package list for #{business.name}"
    check_links "Create another package",
                "Return to main business page"
    within('.table') do
      check_content "Package Name",
                    "Description",
                    "Package Count",
                    "Price",
                    "Service",
                    "#{package_one.name}",
                    "#{package_two.name}",
                    "#{package_one.count}",
                    "#{package_two.count}",
                    "$400.00",
                    "$200.00",
                    "First Service",
                    "Second Service"
      check_links "#{package_one.name}",
                  "#{package_two.name}",
                  "Edit",
                  "Delete"
    end
  end
    
  test "view a specific package" do
    click_link "Packages - 2"
    
    click_link "#{package_one.name}"
    
    assert_equal business_package_path(business, package_one), current_path
    assert_title "Package Details"
    assert_css "table"
    check_content "Package Details for #{package_one.name}",
                  "Package Name:",
                  "Description:",
                  "Package count:",
                  "Price:",
                  "Service:",
                  "#{package_one.name}",
                  "#{package_one.count}",
                  "$400.00",
                  "First Service"
    check_links "Edit this package",
                "Delete this package",
                "Return to main business page"
  end
                  
  
end