Feature: Customer shows Gift Certificates
  In order to manage gift certificates my customers have purchased
  As an owner of a business 
  I can view all and each previous purchase

  Background: Logging in with a business
    Given I am logged in
    And I have created one business
    And I have created two customers
    And I have created two services
    And I have created two gift certificates
    Then I logout
    When I login with valid credentials
    Then I am at my business profile page
    And I expect to see a link to "Gift Certificates"
    When I click the "Gift Certificates" link
    Then I expect to see the title "All Gift Certificates Sold"
    And I expect to see content "All Gift Certificates Sold"


  Scenario: Viewing the index
    And I expect to see content "Certificate Number"
    And I expect to see content "Amount"
    And I expect to see content "Redeemed?"
    And I expect to see content "Purchased By"
    And I expect to see content "Purchased On"
    And I expect to see content "1"
    And I expect to see content "2"
    And I expect to see content "$100.00"
    And I expect to see content "$125.00"
    And I expect to see content "No"
    And I expect to see content "Art Mills"
    And I expect to see a link to "Show"
    And I expect to see a link to "Edit"
    And I expect to see a link to "Destroy"
    
  Scenario: Viewing the individual certificate
    When I click the "1" link
    Then I expect to see the title "Gift Certificate Details"
    And I expect to see a link to "Return to main business page"
    And I expect to see a link to "Return to customer page"
    And I expect to see content "Gift Certificate Details"
    And I expect to see content "Certificate Number:"
    And I expect to see content "Certificate Amount: $100"
    And I expect to see content "Redeemed?: No"
    And I expect to see content "Purchased By: Art Mills"
    And I expect to see content "Purchased On:"
    And I expect to see content "Certificate Comments: This is first"
    