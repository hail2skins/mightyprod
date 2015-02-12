Feature: Owner edits business
	In order to alter information about my business
	as an owner with a registered business
	I should be able to edit my business information.

	Background: Logging in and all that jazz
		Given I am logged in
	  And I am at my owner profile page
	  And I have created one business
	  And I visit my business profile page

	  Scenario: Successfully editing business
	  	And I should see a link to "Edit"
	  	And I can see my business name in a link
	  	When I click the "Edit" link
	  	Then I am at my business edit page
	  	And I expect to see the title "Edit"
	  	And I should see content "Editing"
	  	When I fill in "Business name" with "Awesome Test Business"
	  	And I click the "Submit my business information" button
	  	Then I should see content "Your business information has been successfully updated."
	  	And I am at my owner profile page
	  	And I should see a link to "Awesome Test Business"

	  	Scenario: Failing to edit a business
	  		And I should see a link to "Edit"
	  		And I can see my business name in a link
	  		When I click the "Edit" link
	  		Then I am at my business edit page
	  		And I expect to see the title "Edit"
	  		And I should see content "Editing"
	  		When I fill in "Business name" with ""
	  		And I click the "Submit my business information" button
	  		Then I should see content "Please review the problems below:"
	  		And I should see content "can't be blank"
