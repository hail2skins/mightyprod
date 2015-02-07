Feature: Business edits customers
	In order to keep my business customers updated
	As a business owner who wants to keep information up to date
	I can edit customer information

	Background: Logging in with a business
	  Given I am logged in
	  And I have created one business
	  And I have created two customers
      Then I logout
      When I login with valid credentials
	
	  Scenario: Showing customers
	  	And I expect to see a link to "Customers"
	  	And I expect to see a link to "Art"
	  	When I click the "Art" link
	  	Then I expect to see a link to "Edit Customer"
	  	When I click the "Edit Customer" link
	  	Then I expect to see a link to "Back"
      When I click the "Back" link
      Then I am at my business profile page
      When I click the "Art" link
      Then I expect to see a link to "Edit Customer"
      When I click the "Edit Customer" link
      Then I expect to see a form to edit information
      When I fill in "First name" with ""
      And I fill in "Email" with "I@cute"
      And I click the "Update Customer" button
      Then I expect to see content "First name can't be blank"
      And I expect to see content "Email is invalid"
      When I fill in "First name" with "Arthur"
      And I fill in "Last name" with ""
      Then I expect to see content "First name can't be blank"
	  	And I fill in "First name" with "Arthur"
	  	And I fill in "Middle name" with "Raphael"
	  	And I fill in "Last name" with "Miller"
	  	And I fill in "Email" with "test@test.com"
	  	And I fill in "Referred by" with "Rebecca Looney"
      And I fill in "Phone Number" with "6123333333"
	  	And I click the "Update Customer" button
	  	Then I expect to see content "Information for Arthur Miller has been updated."
      And I am at my business profile page
      And I expect to see content "Arthur"
      And I expect to see content "Miller"
      And I expect to see content "test@test.com"
      And I expect to see content "(612) 333-3333"

