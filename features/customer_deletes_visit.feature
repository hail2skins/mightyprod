Feature: Customer deletes visit
  In order to track my customers
  my business customers should have their visits tracked and
  I can delete visits to each of my customers to track their interaction

  Background: Logging in with a business
    Given I am logged in
    And I have created one business
    And I have created two customers
    And I have created a visit for each customer
    Then I logout
    When I login with valid credentials


  Scenario: Editing a visit from the customer show page
    Then I expect to see a link to "Art"
    When I click the "Art" link
    Then I am at my customer show page
    And I expect to see content "Last Visit:"
    And I expect to see a link to "10/24/2014"
    When I click the "10/24/2014" link
    Then I expect to see a link to "Delete this visit"
    When I click the "Delete this visit" link
    Then I am at my customer show page
    And I expect to see content "Visit deleted."
    
  Scenario: Deleting from the index page
    And I expect to see a link to "Art"
    When I click the "Art" link
    Then I expect to see a link to "1"
    When I click the "1" link
    And I expect to see a link to "Destroy"
    When I click the "Destroy" link
    Then I am at my customer show page
    And I expect to see content "Visit deleted."
    