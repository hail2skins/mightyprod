Feature: login
  In order to get access to protected sections of the site
  A owner
  Should be able to login

    Scenario: owner is not signed up
      Given I do not exist as an owner
      When I login with valid credentials
      Then I see an invalid login message
      And I should be logged out

    Scenario: owner signs in successfully
      Given I exist as a owner
      And I am not logged in
      When I login with valid credentials
      Then I see a successful login message
      When I return to the site
      Then I should be signed in

    Scenario: owner enters wrong email
      Given I exist as a owner
      And I am not logged in
      When I login with a wrong email
      Then I see an invalid login message
      And I should be logged out
      
    Scenario: owner enters wrong password
      Given I exist as a owner
      And I am not logged in
      When I login with a wrong password
      Then I see an invalid login message
      And I should be logged out
