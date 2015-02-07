Feature: Business edits package
  In order to keep special packages for my business up to date
  my business can change the packages I've created so
  I can edit a package with current information and changes

  Background: Logging in with a business
    Given I am logged in
    And I have created one business
    And I have created one package
    Then I logout
    When I login with valid credentials
    Then I am at my business profile page
    Then I am at my business profile page
    And I expect to see a link to "Packages - 1"
    When I click the "Packages - 1" link
    
  Scenario: Delete a package from the package index page
    And I expect to see a link to "Destroy"
    When I click the "Destroy" link
    Then I am at my business profile page
    And I expect to see content "Package deleted."
    And I expect to see a link to "Add new package"
    
  Scenario: Delete a package from the package show page
    Then I expect to see a link to "First Customer Package"
    When I click the "First Customer Package" link
    Then I am at my business package show page
    And I expect to see a link to "Delete this package"
    When I click the "Delete this package" link
    Then I am at my business profile page
    And I expect to see content "Package deleted."