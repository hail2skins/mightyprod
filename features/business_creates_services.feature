Feature: Business creates services
	In order to attach the services I provide my customers
	my business should have a list of services
	I can create as an owner to have available

	Background: Logging in with a business
	  Given I am logged in
	  And I have created one business
	  And I have created two customers
	  Then I logout
      When I login with valid credentials

	  Scenario: Creating a service
	    Then I am at my business profile page
	  	And I expect to see content "Services Information"
	  	And I expect to see content "Please tell us what types of services your business provides."
	  	And I expect to see a link to "Add a service your business provides now!"
	  	When I click the "Add a service your business provides now!" link
	  	Then I expect to see the title "Add a service"
	  	And I expect to see content "Add a service"
	  	And I expect to see a form to add a new service
	  	And I expect to see content "Service name"
	  	And I expect to see content "Description"
	  	And I expect to see content "Price"
	  	And I expect to see a link to "Back to main business page"
	  	When I fill in "Service name" with "Microderm"
	  	And I fill in "Description" with "Full service service"
	  	And I fill in "Price" with "125"
	  	Then I click the "Create Service" button
	  	Then I am at my business profile page
	  	And I expect to see content "New service created."
	  	And I expect to see a link to "Number of services:"
	  	But I do not expect to see content "Please tell us what types of services your business provides."
	  	And I do not expect to see a link to "Add a service your business provides now!"
	  	
	  	Scenario: Creating a service without proper fields
	  	  When I click the "Add a service your business provides now!" link
	  	  And I fill in "Service name" with ""
	  	  And I fill in "Price" with ""
	  	  Then I click the "Create Service" button
	  	  Then I expect to see content "2 errors prohibited this visit from being saved:"
	  	  And I expect to see content "Prices amount can't be blank"
	  	  And I expect to see content "Name can't be blank"
	  	
