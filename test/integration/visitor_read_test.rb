require "test_helper"

class VisitorReadTest < ActionDispatch::IntegrationTest
  test "visit home page as a visotor" do
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
    check_content "Small Businesses Gone Mighty!"
    
  end

end
