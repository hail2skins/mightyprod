Feature: Customer deletes package
  In order to track special deals my customers have
  as a business with a package created and a customer who has purchased a deal
  I can delete the packaged deal from the customer

  Background: Logging in with a business
    Given I am logged in
    And I have created one business
    And I have created two customers
    And I have created one package
    And I have created one deal
    Then I logout
    When I login with valid credentials
    Then I am at my business profile page
    And I expect to see a link to "Art"
    When I click the "Art" link
    Then I am at my customer show page
    And I expect to see content "Packages in progress: 1"
    And I expect to see a link to "Packages in progress:"
    And I expect to see a link to "My Package History"

  Scenario: Deleting a package from the index
    When I click the "Packages in progress:" link
    Then I expect to see a link to "Destroy"
    When I click the "Destroy" link
    Then I am at my customer show page
    And I expect to see content "Customer deal has been deleted."
    And I expect to see a link to "Purchase a package?"
    But I do not expect to see content "Packages in progress:"