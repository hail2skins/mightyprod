Feature: Owner deletes business
	In order to remove a business I no longer own or manage
	as an owner who has previously registered a business
	I should be able to delete that business, but, 
	it will only be soft deleted in reality.

	Background: Logging in and all that jazz
		Given I am logged in
	  And I am at my owner profile page
	  And I have created one business
	  And I visit my business profile page

	  @javascript
	  Scenario: Owner soft deletes a business
	  	And I should see a link to "Delete"
	  	When I click the "Delete" link
	  	Then a prompt asks "Are you sure?"
 			When I accept popup
 			Then I am at my owner profile page
 			And I should see content "You have deleted this registered business."

