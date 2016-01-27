Feature: Business shows visits
  In order to track my customers
  my business customers should have their visits tracked and
  I can view all customer visits from my business page.

  Background: Logging in with a business
    Given I am logged in
    And I have created one business
    And I have created two customers
    And I have created a visit for each customer
    Then I logout
    When I login with valid credentials


  Scenario: Viewing the business visits index page
    Then I am at my business profile page
    And I expect to see a link to "Total Customer Visits: 2"
    When I click the "Total Customer Visits: 2" link
    Then I expect to see the title "Visits for My Great Business"
    And I expect to see content "Visits for My Great Business"
    And I expect to see content "I'm Art's customer and my skin is sensitive"
    And I expect to see content "I'm David's customer and my skin is sensitive"
    And I expect to see content "10/24/2014"
    And I expect to see a link to "Edit"
    And I expect to see a link to "Destroy"
    And I expect to see a link to "Return to main business page"




