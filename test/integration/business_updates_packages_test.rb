require "test_helper"

class BusinessUpdatesPackagesTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  def package_one
    packages(:single_service_package)
  end
  
  
  test "edit package from package index" do
    click_link "Packages - 2"

    check_content "#{package_one.count}",
                  "$400.00",
                  "First Service"
    within(".table") do
      first(:link, "Edit").click
    end
 
    assert_equal edit_business_package_path(business, package_one), current_path
    assert_title "Edit Package Details"
    check_content "Edit Package Details for #{package_one.name}"
    assert page.has_no_checked_field?("Second Service"), 
                                      "Field -- Second Service is checked and should not be"
    assert page.has_checked_field?("First Service"),
                                   "Field -- First Service should be checked but is not."
    fill_in "Package Name", with: "Blue"
    fill_in "Number of visits in package?", with: 8
    fill_in "Price", with: 500
    choose "Second Service"
    click_button "Update Package"
    
    click_link "Packages - 2"
    
    check_content "Blue",
                  "8",
                  "$500.00"
    refute page.has_content?("First Service"), "Page still has content First Service."
    refute page.has_content?("$400.00"), "Page still has content $400."
    refute page.has_content?("Single Service Package"), "Page still has content Single Service Package."
    within(".table") do
      first(:link, "Edit").click
    end
    
    assert page.has_checked_field?("Second Service"), "Field -- Second Service is not checked."
    assert page.has_no_checked_field?("First Service"), "Field -- First Service should not be checked but is."
  end
  
  test "edit a package from the package show page" do
    click_link "Packages - 2"
    
    click_link "#{package_one.name}"
    
    check_content "Package Name: #{package_one.name}",
                  "Package count: 6",
                  "Price: $400.00",
                  "Service: First Service"
    click_link "Edit this package"
    
    assert_equal edit_business_package_path(business, package_one), current_path
    fill_in "Package Name", with: "Blue"
    fill_in "Number of visits in package?", with: 8
    fill_in "Price", with: 500
    choose "Second Service"
    click_button "Update Package"
    
    click_link "Packages - 2"
    
    click_link "Blue"
    
    refute page.has_content?("First Service"), "Page still has content First Service."
    refute page.has_content?("$400.00"), "Page still has content $400."
    refute page.has_content?("Single Service Package"), "Page still has content Single Service Package."    
  end
  
  test "fail to edit a package due to required fields" do
    click_link "Packages - 2"
    
    first(:link, "Edit").click
    
    fill_in "Package Name", with: ""
    fill_in "Number of visits in package?", with: ""
    fill_in "Price", with: ""
    click_button "Update Package"
    check_content "Please review the problems below:",
                  "Name Package Name can't be blank",
                  "Count Number of visits in package can't be blank",
                  "Amount can't be blank"
  end
  
end