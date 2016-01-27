require "test_helper"

class OwnerEditsBusinessTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  test "owner successfully edits a business" do
    check_links "Awesome Business"
    refute page.has_link? "Awesome Cool Business"
    within(".business") do
      check_links "Edit"
      click_link "Edit"
    end
    
    assert_equal edit_owner_business_path(owner, business), current_path
    assert_title "Edit"
    check_content "Editing"
    
    fill_in "Business name", with: "Awesome Cool Business"
    click_button "Submit my business information"
    
    assert_equal owner_business_path(owner, business), current_path
    check_content "Your business information has been successfully updated."
    
    check_links "Awesome Cool Business"
    refute page.has_link? "Test Business"
 end
 
 test "owner unsuccessfully edits a business" do
   within(".business") do
     click_link "Edit"
   end
   
   fill_in "Business name", with: ""
   click_button "Submit my business information"
   check_content "Please review the problems below:",
                 "Name can't be blank"
 end


end
