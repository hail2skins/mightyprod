Feature: Business deletes customers
  In order to keep my business customers list accurate
  As a business owner who wants to remove customers I no longer provide service to
  I can delete a customer

  Background: Logging in with a business
    Given I am logged in
    And I have created one business
    And I have created two customers
    Then I logout
    When I login with valid credentials

  Scenario: Showing customers
    And I expect to see a link to "Customers"
    And I expect to see a link to "Art"
    When I click the "Art" link
    Then I expect to see a link to "Delete Customer"
    When I click the "Delete Customer" link
    Then I expect to see content "Customer has been deleted."
    And I am at my business profile page
