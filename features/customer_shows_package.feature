Feature: Customer shows package
  In order to track special deals my customers have
  as a business with a package created and a customer who has purchased a deal
  I can view a list of all purchased deals and each individual deal

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

  Scenario: Viewing a package from the Packages in Progress link
    When I click the "Packages in progress:" link
    Then I expect to see the title "Packages for Art Mills"
    And I expect to see content "Packages for Art Mills"
    And I expect to see content "Package Name"
    And I expect to see content "Date Purchased"
    And I expect to see content "Remaining Visits"
    And I expect to see content "Date Completed"
    And I expect to see content "First Customer Package"
    And I expect to see content "11/13/2014"
    And I expect to see content "6"
    And I expect to see a link to "Purchase another package"
    And I expect to see a link to "Show Details"
    When I click the "Show Details" link
    Then I expect to see the title "Package Details"
    And I expect to see content "Package Details"
    And I expect to see content "Package Name"
    And I expect to see content "Date Purchased"
    And I expect to see content "Remaining Visits"
    And I expect to see content "Date Completed"
    And I expect to see content "First Customer Package"
    And I expect to see content "11/13/2014"
    And I expect to see content "6"    
    
  Scenario: Viewing a package from the My Package History button
    When I click the "My Package History" link
    Then I expect to see the title "Packages for Art Mills"
    And I expect to see content "Packages for Art Mills"
    And I expect to see content "Package Name"
    And I expect to see content "Date Purchased"
    And I expect to see content "Remaining Visits"
    And I expect to see content "Date Completed"
    And I expect to see content "First Customer Package"
    And I expect to see content "11/13/2014"
    And I expect to see content "6"
    And I expect to see a link to "Purchase another package"
    And I expect to see a link to "Show Details"
    When I click the "Show Details" link
    Then I expect to see the title "Package Details"
    And I expect to see content "Package Details"
    And I expect to see content "Package Name"
    And I expect to see content "Date Purchased"
    And I expect to see content "Remaining Visits"
    And I expect to see content "Date Completed"
    And I expect to see content "First Customer Package"
    And I expect to see content "11/13/2014"
    And I expect to see content "6"       