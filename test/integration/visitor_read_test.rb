require "test_helper"

class VisitorReadTest < ActionDispatch::IntegrationTest
  def setup
    visit root_path
  end
  
  test "visit home page as a visitor" do
    visit root_path
    
    assert page.has_title?("Mighty Smalls"), "Title -- Mighty Smalls not available."
    
    #check page links
    check_links "Home",
                "Help",
                "About",
                "Contact",
                "Login",
                "Sign up now!"
                
    #page content
    check_content "Small Businesses Gone Mighty!",
                  "SITE IS CURRENTLY IN CLOSED ALPHA TESTING."
  end
  
  test "checking the Help link" do 
   click_link "Help"
    
   assert_equal(help_path, current_path)
   assert_title("Help")
   check_content "Help",
                 "We will be providing a thorough help page 
                 with instructions on how to use the site as 
                 we near opening it to beta testing."
    
  end
  
  test "checking the About link" do
    click_link "About"
    
    assert_equal(about_path, current_path)
    assert_title "About"
    check_content "About",
                  "About Mighty Smalls"
                  
    within(".about") do
     check_content "Small business, big features"
    end
  end
  
  test "checking the Contact link" do
    click_link "Contact"
    
    assert_equal contact_path, current_path
    assert_title "Contact"
    check_content "Contact",
                  "We will have a standard contact form provided on this page as we near beta testing."
  end
  

  test "checking the Signup link" do
  
    visit signup_path
    
    assert_field "Email"
    assert_field "Password"
    assert_field "Confirm Password"
    assert_field "First name"
    assert_field "Middle name"
    assert_field "Last name"
    assert_button "Create my account"
    
    check_links "Login",
                "Didn't receive confirmation instructions?",
                "Didn't receive unlock instructions?"
                
    assert_title "Sign up"
    check_content "Sign up"
  end
  
  test "checking the Login link" do
    click_link "Login"
    
    assert_equal(login_path, current_path)
    assert_field "Email"
    assert_field "Password"
    find(:checkbox, "Remember me")
    assert_button "Login"
    
    check_links "Sign up",
                "Forgot your password?",
                "Didn't receive confirmation instructions?",
                "Didn't receive unlock instructions?"
                
    assert_title "Login"
    check_content "Login"
  end

end
