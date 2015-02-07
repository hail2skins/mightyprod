Feature: Visit creates deal
  In order to automatically track customer deals
  when a customer has a new visit
  I can select an option to link it to a purchased deal and decrease the count of that deal

  Background: Logging in with a business
    Given I am logged in
    And I have created one business
    And I have created two customers
    And I have created one package
    And I have created one deal
    Then I logout
    When I login with valid credentials
    Then I am at my business profile page
    
    Scenario: Creating a new visit that links to a customer package
      And I expect to see a link to "Art"
      When I click the "Art" link
      When I click the "Packages in progress:" link
      Then I expect to see content "6"
      When I click the "Return to customer page" link
      Then I expect to see content "New visit for Art Mills"
      When I click the "New visit for Art Mills" link
      Then I expect to see content "Is this a special deal visit?"
      And I expect to see the checkbox checked
      When I click the "Create Visit" button
      Then I am at my business profile page
      When I click the "Art" link
      And I click the "Packages in progress:" link
      Then I expect to see content "5"
      
    Scenario: Creating a visit that sets a package to inactive
      When I click the "Art" link
      And I click the "Packages in progress:" link
      And I click the "Edit" link
      And I fill in "Remaining Visits" with "1"
      And I click the "Update Deal" button
      When I click the "New visit for Art Mills" link
      And I click the "Create Visit" button
      When I click the "Art" link
      Then I expect to see content "Purchase a package?"
      And I expect to see content "Completed packages:"
      But I do not expect to see content "Packages in progress:"
      When I click the "New visit for Art Mills" link
      Then I do not expect to see content "Is this a special deal visit?"