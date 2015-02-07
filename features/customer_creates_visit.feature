Feature: Customer creates visit
  In order to track my customers
  my business customers should have their visits tracked and
  I can add visits to each of my customers to track their interaction

  Background: Logging in with a business
    Given I am logged in
    And I have created one business
    And I have created two customers
    And I have created two services
    Then I logout
    When I login with valid credentials

  Scenario: Creating a new visit from the main business page
    Then I expect to see content "Visits"
    And I expect to see a link to "Art"
    When I click the "Art" link
    Then I expect to see a link to "New visit"
    When I click the "New visit" link
    Then I expect to see content "New visit for Art Mills"
    And I expect to see the title "Add a visit for Art Mills"
    And I expect to see a form to add a new visit
    And I expect to see content "Visit notes"
    And I expect to see content "Date of visit"
    And I expect to see content "Service(s) Provided"
    When I fill in "Visit notes" with "Skin was sensitive today."
    Then I select date from date selector
    And I check "Microderm"
    And I check "Facial"
    And I click the "Create Visit" button
    Then I am at my business profile page
    And I expect to see content "Total Customer Visits: 1"
    And I expect to see a link to "1"
    And I expect to see content "Visit added for Art Mills"
    When I click the "Art" link
    Then I am at my customer show page
    And I expect to see content "Last Visit: 10/24/2014"
    And I expect to see content "Total Visits:"
    And I expect to see a link to "1"


