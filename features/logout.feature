Feature: Logout
  To protect my account from unauthorized access
  A signed in owner
  Should be able to logout

    Scenario: Owner signs out
      Given I am logged in
      When I logout
      Then I should see a signed out message
      Then I should be logged out