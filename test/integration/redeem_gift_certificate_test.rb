require "test_helper"

class RedeemGiftCertificateTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  def teardown
    click_link "Logout"
  end
  
  def business
    businesses(:business)
  end
  
  def customer
    customers(:art)
  end
  
  def certificate
    gift_certificates(:first_certificate)
  end

  test 'redeem gift certificate from main business page' do
  
    click_link "Gift Certificates"
  
    click_link "Redeem"
  
    assert_equal redeem_business_gift_certificate_path(business, certificate), current_path,
              "Expected to be at business_gift_certificates_path but at #{current_path}."
              
    assert page.has_title?("Redeem Gift Certificate"), "Title -- Redeem Gift Certificate not available."
  
    #confirm redeem_business_gift_certificate_path has links we expect
    check_links("Return to customer profile page", 
                "Return to main business page")
              
    #confirm expected content on page exists
    check_content("Redeem Gift Certificate",
                  "Certificate Amount: $#{certificate.prices.first.amount.to_i.round(2)}",
                  "Redemption comment",
                  "Redeem this gift certificate?")
                
    #try to figure out how to test placeholder text
                
    assert_equal(has_checked_field?("Redeem this gift certificate?"), true, 'Checkbox -- Redeem this gift certificate? not checked.')
  
    fill_in "Redemption comment", with: "Another customer redeemed this today."
  
    click_button "Redeem Gift Certificate"
  
    assert_equal gift_certificates_business_path(business), current_path, "Expected to be at the gift certificates business index page, but at #{current_path}."

    #check content you expect to have changed with successful redemption
    check_content("Gift Certificate Redeemed",
                  "Yes",
                  Time.now.strftime("%m/%d/%Y")) #not really a good test.   need to figure out fixtures.
               
    refute page.has_content?("No"), "Content -- No is still present."
    
    click_link "1"
  
    #check new content you expect to see on this page:
    check_content("Another customer redeemed this today.",
                  "Yes",
                  Time.now.strftime("%m/%d/%Y"))
                  
    refute page.has_content?("No"), "Content -- No is still present."
    
    click_link "Return to main business page"
    
  end
  
  test 'fail to check box to redeem gift certificate from main business page' do
    
    click_link "Gift Certificates"
    
    click_link "Redeem"
    
    fill_in "Redemption comment", with: "Not gonna do it."
    
    uncheck("Redeem this gift certificate?")
    
    click_button "Redeem Gift Certificate"
    
    assert_equal gift_certificates_business_path(business), current_path, "Expected to be at the gift certificates business index page, but at #{current_path}."
    
    #check for content you expect to see on this page in this failure scenario
    check_content("You did not check the box, so the certificate is not redeemed.",
                  "No")
    
    refute page.has_content?("Yes"), "Content -- Yes is present and should not be."
    
    click_link "1"
    
    refute page.has_content?("Not gonna do it."), "Content -- Not gonna do it shouldn't be here."
    
  end
  
  test "different redeem page for already redeemed certificate" do
    certificate.update(active: false, date_redeemed: Time.now, redemption_comment: "Work baby.")
    
    click_link "Gift Certificates"
    
    #Just checking our update above took
    check_content("Yes")
    
    click_link "Redeem"
    
    #check content after redemption selected to reflect already redeemed.
    check_content("Certificate Already Redeemed",
                  "Redemption comments: Work baby.",
                  "Date Redeemed: #{certificate.date_redeemed.to_date.strftime("%m/%d/%Y")}")
                  
    #added a link on the alternate page.   check it.
    check_links("Return to gift certificate index page")
    
    click_link "Return to gift certificate index page"
    
    assert_equal gift_certificates_business_path(business), current_path, 
                "Expected to be at the gift_certificates_business_path, but at #{current_path}."
    
  end
  

end
