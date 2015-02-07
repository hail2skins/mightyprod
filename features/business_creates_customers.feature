Feature: Business creates customers
	In order to conduct business
	my business should be able to add customers
	I can create as an owner of the business

	Background: Logging in with a business
		Given I am logged in
		And I have follow prompts to add a business

	  Scenario: Creating first customer
	  	Then I expect to see content "Customer Information"
	  	And I expect to see content "You have not yet added any customers."
	  	And I expect to see a link to "Add a customer for your business now!"
	  	When I click the "Add a customer for your business now!" link
		Then I expect to see a form to add customer information
		And I expect to see a header with "New Customer"
	  	And I expect to see the title "Create a customer"
	  	When I fill in "Email" with "Mommy loves me"
	  	And I click the "Create Customer" button
	  	Then I expect to see content "3 errors prohibited this customer from being saved:"
	  	And I expect to see content "First name can't be blank"
	  	And I expect to see content "Last name can't be blank"
	  	And I expect to see content "Email is invalid"
	  	When I fill in "First name" with "Kathy"
	  	And I fill in "Middle name" with ""
	  	And I fill in "Last name" with "Davis"
	  	And I fill in "Email" with "test@test.com"
        And I fill in "Referred by" with ""
	  	And I fill in "Phone Number" with "65155512123"
   	    When I click the "Create Customer" button
        Then I expect to see content "1 error prohibited this customer from being saved:"
        And I expect to see content "Phones number is the wrong length (should be 10 characters)"
        When I fill in "Phone Number" with "1"
        And I click the "Create Customer" button
        Then I expect to see content "Phones number is the wrong length (should be 10 characters)"
        When I fill in "Phone Number" with "Hi mom"
        And I click the "Create Customer" button
        Then I expect to see content "Phones number is the wrong length (should be 10 characters)"
        And I expect to see content "Phones number is not a number"
        When I fill in "Phone Number" with "6515551212"
        And I click the "Create Customer" button
	  	Then I expect to see content "Customer added."
	  	Then I expect to see content "Customer Information"
	  	But I expect to not see content "You have not yet added any customers."
	  	Then I expect to see a link to "Customers"
        And I expect to see content "Total Customer Visits: 0"
	  	And I expect to see a link to "Add"
	  	And I expect to see content "Customers: 1"
	  	And I expect the page to have a table
	  	And I expect to see a link to "Kathy"
	  	And I expect to see content "test@test.com"
        And I expect to see content "(651) 555-1212"
        And I expect to see content "Visits"
        And I expect to see a link to "0"
	  	And I expect to see a link to "Edit"
	  	And I expect to see a link to "Delete"
