Feature: Customer edits package
  In order to track special deals my customers have
  as a business with a package created and a customer who has purchased a deal
  I can edit an individual deal

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

  Scenario: Editing a package from the Packages in Progress link
    When I click the "Packages in progress:" link
    Then I expect to see a link to "Edit"
    When I click the "Edit" link
    Then I expect to see the title "Edit Package"
    And I expect to see content "Edit Package"
    And I expect to see content "Package Name"
    And I expect to see content "Date Purchased"
    And I expect to see content "Remaining Visits"
    And I expect to see content "First Customer Package"
    And I expect to see content "6"
    When I fill in "Remaining Visits" with "4"
    And I click the "Update Deal" button
    Then I am at my customer show page
    And I expect to see content "Deal Updated"
    When I click the "Packages in progress:" link
    Then I expect to see content "4"
    
  Scenario: Editing a package from the My Package History link
    When I click the "My Package History" link
    Then I expect to see a link to "Edit"
    When I click the "Edit" link
    Then I expect to see the title "Edit Package"
    And I expect to see content "Edit Package"
    And I expect to see content "Package Name"
    And I expect to see content "Date Purchased"
    And I expect to see content "Remaining Visits"
    And I expect to see content "First Customer Package"
    And I expect to see content "6"
    When I fill in "Remaining Visits" with "4"
    And I click the "Update Deal" button
    Then I am at my customer show page
    And I expect to see content "Deal Updated"
    When I click the "Packages in progress:" link
    Then I expect to see content "4"   
    
  Scenario: Editing package so it goes to completed and then reverses
    When I click the "Packages in progress:" link
    Then I expect to see a link to "Edit"
    When I click the "Edit" link
    And I fill in "Remaining Visits" with "0"
    And I click the "Update Deal" button
    Then I am at my customer show page
    And I expect to see a link to "Purchase a package?"
    And I expect to see content "Completed packages:"
    But I do not expect to see content "Packages in progress:"
    When I click the "My Package History" link
    Then I expect to see today's date
    When I click the "Edit" link
    Then I fill in "Remaining Visits" with "1"
    And I click the "Update Deal" button
    Then I am at my customer show page
    And I expect to see content "Packages in progress:"
    But I do not expect to see content "Deals completed:"
    
    
  