require "test_helper"

class ShowGiftCertificateTest < ActionDispatch::IntegrationTest
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
  
  test "show gift certificate from customer show page" do
    click_link customer.first_name
    
    click_link "Gift Certificates Purchased"
    
    assert_equal customer_gift_certificates_path(customer), current_path,
                 "Expected to be at the customer gift certificates index, but at #{current_path}."
                 
    assert page.has_title?("Gift Certificates Purchased by #{customer.name}"),
                           "Title -- Gift Certificates Purchased by #{customer.name} not available."
                      
    assert page.has_table?('gift_certificates'),
                         "Table -- gift_certificates table not available."
                         
    #Checks all table structure content expected words.   method provided above.
    check_content("Gift Certificates Purchased by #{customer.name}", "Certificate Number", "Amount", "Redeemed?", "Date Redeemed", "Purchased By", "Purchased On")
    
    #Checks table data fed by database is accurate
    check_content("1", "$100.00", "No", customer.name, customer.created_at.to_date.strftime("%m/%d/%Y"))
    
    #Checks certificate index page for page specific links.
    check_links("1", "Edit", "Return to customer profile view", "Return to main business page")
    
    click_link "1"
    
    assert_equal customer_gift_certificate_path(customer, certificate), current_path,
                "Expected to be at customer gift certificate show page, but at #{current_path}."
                
    #checks all table column content on customer show page.
    check_content("Certificate Number", 
                  "Amount", 
                  "Redeemed?", 
                  "Date Redeemed", 
                  "Purchased By", 
                  "Purchased On", 
                  "Redemption Comment")
    
    #checks content that should be fed from the database for an unredeemed cert on the show page
    check_content("1", "$100.00", "No", customer.name, customer.created_at.to_date.strftime("%m/%d/%Y"))
    
    #checks all links on the customer show page
    check_links("Edit", "Return to customer profile view", "Return to main business page")
  end
  
  test "show gift certificate from main business page" do
    click_link "Gift Certificates"
    
    assert_equal gift_certificates_business_path(business), current_path,
                "Expected to be at the business gift certificates index, but at #{current_path}."
                
    assert page.has_title?("All Gift Certificates Sold"), 
                           "Title -- All Gift Certificates Sold not available."
                           
    assert page.has_table?("gift_certificates"), 
                          "Table -- gift_certificates table not available."
                          
    # checks table structure content on gift_certificates.business index page.
    check_content("Certificate Number", "Amount", "Redeemed?", "Date Redeemed", "Purchased By", "Purchased On")
    
    # checks database specific content on gift_certificates.business index page for unredeemed cert.
    check_content("1", "$100.00", "No", customer.name, customer.created_at.to_date.strftime("%m/%d/%Y"))
    
    #checks links on gift_certificates.business index page
    check_links("1", "Edit", "Redeem", "Return to main business page")
    
    click_link "1"
    
    assert_equal customer_gift_certificate_path(customer, certificate), current_path,
                  "Expected to be at customer gift certificate path, but at #{current_path}."
                  
    #if here, all assertions match the test in the previous test.
  
  end
  
  
end
