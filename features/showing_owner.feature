Feature: Showing owners
In order to see my personal information
as an owner with a business
I should have a profile page with key data

	Background: Logging in
  	Given I am logged in
  	And I am at my owner profile page

  	Scenario: I can navigate links
  		And I should see a link to "Account"
  		When I click the "Account" link
  		Then I should see a link to "Profile"
  		And I should see a link to "Settings"
  		And I should see a link to "Logout"
  		When I click the "Profile" link
  		Then I am at my owner profile page
  		When I click the "Settings" link
  		Then I am at my owner edit page

  		Scenario: I see basic information about myself as an owner
  			And I can see my name in the title
  			And I can see my name in a link