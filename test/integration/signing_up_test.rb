require "test_helper"

class SigningUpTest < ActionDispatch::IntegrationTest
 
 test "successfully sign up" do
   visit signup_path
 
   fill_in "Email", with: "justa@testaccount.com"
   fill_in "owner_password", with: "password"
   fill_in "Confirm Password", with: "password"
   fill_in "First name", with: "Test"
   fill_in "Last name", with: "User"
   click_button "Create my account"

   
   assert_equal root_path, current_path, "Expected to be at root but at #{current_path}."
   check_content "A message with a confirmation 
                  link has been sent to your email 
                  address. Please open the link to 
                  activate your account."
  end
  
  test "unsuccessfully sign up without required information" do
    visit signup_path
    
    click_button "Create my account"
    
    #assert_equal signup_path, current_path, "Expected to be at the signup_path but at #{current_path}."
    check_content "Please review the problems below:",
                  "Email can't be blank",
                  "Password can't be blank",
                  "First name can't be blank",
                  "Last name can't be blank"
  end
 
end
