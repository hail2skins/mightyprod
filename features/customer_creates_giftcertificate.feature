Feature: Customer creates Gift Certificate
  In order for my customers to give my service to others
  my business customers should have the ability to purchase gift certificates
  I can add  to each of my customers to their gifts

  Background: Logging in with a business
    Given I am logged in
    And I have created one business
    And I have created two customers
    And I have created two services
    Then I logout
    When I login with valid credentials

  Scenario: Creating a gift certificate from the customer show page
    Then I am at my business profile page
    And I expect to see a link to "Art"
    When I click the "Art" link
    Then I am at my customer show page
    And I expect to see a link to "Buy Gift Certificate"
    When I click the "Buy Gift Certificate" link
    Then I expect to see the title "Purchase a Gift Certificate"
    And I expect to see content "Purchase a Gift Certificate"
    And I expect to see a link to "Back to business page"
    And I expect to see a link to "Back to customer view"
    And I expect to see content "Certificate Amount"
    And I expect to see content "Certificate Comment"
    And I expect to see content "1"
    When I fill in "Certificate Amount" with "120"
    And I fill in "Certificate Comment" with "Purchased by Art as a gift for Kathy."
    And I click the "Create Gift certificate" button
    Then I expect to see content "Gift Certificate created."
    And I expect to see the title "Gift Certificate Details"
    And I expect to see a link to "Return to main business page"
    And I expect to see a link to "Return to customer page"
    And I expect to see content "Gift Certificate Details"
    And I expect to see content "Certificate Number: 1"
    And I expect to see content "Certificate Amount: $120"
    And I expect to see content "Redeemed?: No"
    And I expect to see content "Purchased By: Art Mills"
    And I expect to see content "Purchased On:"
    And I expect to see content "Certificate Comments: Purchased by Art as a gift for Kathy."
    When I click the "Return to customer page" link
    Then I am at my customer show page
    And I do not expect to see content "Buy Gift Certificate"
    But I expect to see content "Buy More Gift Certificates"
    And I expect to see content "Gift Certificates Purchased: 1"
    
    