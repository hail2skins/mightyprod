Feature: Business edits package
  In order to keep special packages for my business up to date
  my business can change the packages I've created so
  I can edit a package with current information and changes

  Background: Logging in with a business
    Given I am logged in
    And I have created one business
    And I have created two services
    And I have created one package
    Then I logout
    When I login with valid credentials

  Scenario: Edit package
    Then I am at my business profile page
    And I expect to see a link to "Packages - 1"
    When I click the "Packages - 1" link
    Then I expect to see a link to "First Customer Package"
    And I expect to see a link to "Edit"
    When I click the "Edit" link
    Then I expect to see the title "Edit Package Details"
    And I expect to see content "Edit Package Details for First Customer Package"
    And I expect to see a form to edit information
    And I expect to see content "Package Name"
    And I expect to see content "Description"
    And I expect to see content "Number of visits in package?"
    And I expect to see content "Price"
    And I expect to see content "Service"
    When I fill in "Package Name" with "Not So Large A Package"
    And I fill in "Description" with "Package for customers buying a kind of larger package."
    And I fill in "Number of visits in package" with "4"
    And I fill in "Price" with "300"
    And I select "Facial" from "Service provided?"
    When I click the "Update Package" button
    Then I am at my business profile page
    And I expect to see content "Package updated."
    When I click the "Packages - 1" link
    And I click the "Not So Large A Package" link
    Then I expect to see content "Not So Large A Package"
    And I expect to see content "Package for customers buying a kind of larger package."
    And I expect to see content "Package count: 4"
    And I expect to see content "$300"
    And I expect to see content "Facial"
    
