Feature: Business shows package
  In order to see what special packages
  my business has created for my customers
  I can view a list of packages and see the details of each

  Background: Logging in with a business
    Given I am logged in
    And I have created one business
    And I have created two services
    And I have created one package
    Then I logout
    When I login with valid credentials

  Scenario: Show packages from the business profile page
    Then I am at my business profile page
    And I expect to see a link to "Packages - 1"
    When I click the "Packages - 1" link
    Then I expect to see the title "Package list for My Great Business"
    And I expect to see content "Package list for My Great Business"
    And I expect the page to have a table
    And I expect to see a link to "First Customer Package"
    And I expect to see content "First package for my customers."
    And I expect to see content "Price"
    And I expect to see content "$400"
    And I expect to see content "Service"
    And I expect to see content "Microderm"
    And I expect to see content "6"
    When I click the "First Customer Package" link
    Then I expect to see the title "Package Details"
    And I expect to see content "Package Details for First Customer Package"
    And I expect to see content "First package for my customers"
    And I expect to see content "Package count:"
    And I expect to see content "6"
    And I expect to see content "Price: $400"
    And I expect to see content "Service: Microderm"
    
