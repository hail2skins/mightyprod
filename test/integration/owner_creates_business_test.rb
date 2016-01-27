require "test_helper"

class OwnerCreatesBusinessTest < ActionDispatch::IntegrationTest
  def setup
    new_login
  end
  
  def teardown
    click_link "Logout"
  end
  
  def login_owner
    owners(:login_owner)
  end
  
  test "owner successfully creates first business" do
    assert_equal owner_path(login_owner), current_path
    
    check_content "Business Information",
                  "Thank you for signing up. We will need information about your business for you to proceed.",
                  "You have not yet provided us information about your business.", 
                  "Add your business now!", 
                  "Personal Information",
                  "Owner: Login Owner",
                  "Email: login@owner.com"
                  
    click_link "Add your business now!"
    
    assert_equal new_owner_business_path(login_owner), current_path
    assert_title "Create a business"
    check_content "New business"
    
    fill_in "Business name", with: "Another Business"
    fill_in "Description", with: "Aesthetics"
    click_button "Submit my business information"

    check_content "Congratulations.  Your business has been created.",
                  "Another Business"
                  
    check_links "Another Business"
    assert_equal owner_business_path(login_owner, login_owner.businesses.first), current_path
    
    check_content "Services Information",
                  "Please tell us what types of services your business provides.",
                  "Customer Information",
                  "You have not yet added any customers."
                
    check_links "Another Business",
                "Add new package",
                "Gift Certificates",
                "Add a service your business provides now!",
                "Add a customer for your business now!",
                "Back to owner page"
                
    click_link "Back to owner page"
    
    assert_equal owner_path(login_owner), current_path
  end
  
  test "owner unsuccessfuly creates business without required fields" do
    click_link "Add your business now!"
    
    click_button "Submit my business information"
    
    
    check_content "Please review the problems below:",
                  "Name can't be blank"
  end
  
  test "owner with one business creates another" do
    click_link "Add your business now!"
    fill_in "Business name", with: "First Business"
    click_button "Submit my business information"
    click_link "Home"
    
    check_content "First Business"
    refute page.has_content? "Second Business"
    within(".business") do
      click_link "Add"
    end
    
    fill_in "Business name", with: "Second Business"
    click_button "Submit my business information"
    
    assert_equal current_path, owner_path(login_owner)
    check_content "Second Business",
                  "First Business"
  end

end
