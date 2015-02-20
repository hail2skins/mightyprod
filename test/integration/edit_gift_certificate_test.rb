require "test_helper"

class EditGiftCertificateTest < ActionDispatch::IntegrationTest

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
  
  test 'edit gift certificate from customer profile' do

    #assert page.has_title?("#{business.name} Profile Page"), 
    #                       "#{business.name} not present."
    
    click_link "#{customer.first_name}"
    
    #assert_equal business_customer_path(business, customer), current_path
    
    click_link "Gift Certificates Purchased"
    
    #assert_equal customer_gift_certificates_path(customer), current_path
    
    #assert page.has_content?(certificate.prices.last.amount),
    #                        "Correct amount, #{certificate.prices.last.amount}, not listed."
                            
  
    assert page.has_link?("Edit"),
                         "Edit link not available."
                         
    #assert page.has_link?("1"),
    #                     "1 link not available."
    
    click_link "Edit"
    
    assert_equal edit_customer_gift_certificate_path(customer, certificate), current_path
    
    assert page.has_title?("Edit this Gift Certificate"),
                          "Edit this Gift Certificate not in the title."
                          
    assert page.has_content?("Editing this Gift Certificate"),
                            "Editing this Gift Certificate is not available on the page."
                            
    
    assert page.has_field?('Certificate Amount', with: "100.00"),
                          "Certificate Amount of 100 not showing in a form field."
                          
    assert page.has_field?('Certificate Comment', with: "#{certificate.initial_comment}"),
                          "Certificate Comment field with '#{certificate.initial_comment} not showing."
                    
    assert page.has_link?('Back to business page'),
                         "'Back to business page' link is not available."
                         
    assert page.has_link?('Back to customer view'),
                         "'Back to customer view' link is not available."
                         
    fill_in "Certificate Amount", with: "120"
    fill_in "Certificate Comment", with: "Still the first certificate."
    
    click_button "Update Gift certificate"
    
    assert_equal owner_business_path(business.owner, business), current_path
    
    click_link "#{customer.first_name}"
    
    click_link "Gift Certificates Purchased"
    
    assert page.has_content?("$120.00"),
                            "New price of $120 not visible in the table."
                            
    click_link "1"
    
    assert_equal customer_gift_certificate_path(customer, certificate), current_path
    
    assert page.has_content?("Certificate Amount: $120.00"),
                            "New Certificate Amount of $120.00 not visible."
                            
    assert page.has_content?("Certificate Comment: Still the first certificate"),
                            "Content -- New Certificate Comment -- Still the first certificate not found."
    
  end

  test 'edit gift certificate from main business page' do
    click_link "Gift Certificates"
    
    assert_equal gift_certificates_business_path(business), current_path
    
    assert page.has_link? "Return to main business page",
                          "'Return to main business page' not available."
                          
    assert page.has_link? "Edit",
                          "'Edit' link not available."
    
    click_link 'Edit'
    
    assert_equal edit_customer_gift_certificate_path(customer, certificate), current_path

    fill_in "Certificate Amount", with: "120"
    fill_in "Certificate Comment", with: "Still the first certificate."
    
    click_button "Update Gift certificate"
    
    assert_equal owner_business_path(business.owner, business), current_path
    
    click_link "Gift Certificates"
    
    assert page.has_content?("$120.00"),
                            "New price of $120 not visible in the table."
                            
    click_link "1"
    
    assert_equal customer_gift_certificate_path(customer, certificate), current_path
    
    assert page.has_content?("Certificate Amount: $120.00"),
                            "New Certificate Amount of $120.00 not visible."
                            
    assert page.has_content?("Certificate Comment: Still the first certificate."),
                            "New Certificate Comment Still the first certificate not visible."
  
  
  end

end
