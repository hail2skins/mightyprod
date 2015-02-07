Feature: Customer edits visit
  In order to track my customers
  my business customers should have their visits tracked and
  I can edit visits to each of my customers to track their interaction

  Background: Logging in with a business
    Given I am logged in
    And I have created one business
    And I have created two customers
    And I have created two services
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
    Then I expect to see a link to "Edit this visit"
    When I click the "Edit this visit" link
    Then I expect to see a form to edit visit
    And I expect to see the title "Edit this visit"
    And I expect to see content "Editing this visit"
    And I expect to see a link to "Back to business page"
    And I expect to see a link to "Back to customer view"
    And I expect to see content "Visit notes"
    And I expect to see content "I'm Art's customer and my skin is sensitive"
    And I expect to see content "Date of visit"
    And I expect to see content "Service(s) Provided"
    And I expect to see content "Microderm"
    And I expect to see content "Facial"
    When I fill in "Visit notes" with "Art is so cute."
    And I uncheck "Facial"
    And I click the "Update Visit" button
    Then I am at my customer show page
    And I expect to see content "Visit successfully edited."
    When I click the "Art" link
    And I click the "10/24/2014" link
    Then I expect to see content "Art is so cute."
    And I expect to see content "Microderm"
    But I do not expect to see content "Facial"
    




