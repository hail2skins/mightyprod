Feature: Business creates customers
	In order to conduct business
	my business have the ability to see added customers and lists which
	I can view customers and a list of customers as an owner of a business

	Background: Logging in with a business
	  Given I am logged in
	  And I have created one business
	  And I have created two customers
      Then I logout
      When I login with valid credentials
	
	  Scenario: Showing customers
	  	Then I expect to see content "Customer Information"
	  	And I expect to see a link to "Customers"
	  	When I click the "Customers" link
	  	Then I expect to see the title "My Great Business Customers List"
	  	And I expect to see content "Customers List for My Great Business"
	  	And I expect the page to have a table
	  	And I expect to see a link to "David"
	  	And I expect to see a link to "Art"
	  	And I expect to see a link to "Edit"
	  	And I expect to see a link to "Delete"
	  	And I expect to see a link to "Back"
	  	And I expect to see a link to "New Customer"
	  	And I expect to see content "Mills"
	  	And I expect to see content "Michael"
	  	And I expect to see content "art@email.com"
	  	And I expect to see content "david@email.com"
	  	And I expect to see content "Visits"
	  	And I expect to see a link to "0"
	  	When I click the "Art" link
	  	Then I expect to see the title "Art Mills"
	  	And I expect to see content "Art Mills Customer Information"
	  	And I expect to see content "Name: Art Mills"
	  	And I expect to see content "Email: art@email.com"
        And I expect to see content "Last Visit: None Recorded"
        And I expect to see content "Total Visits"
        And I expect to see a link to "0"
	  	And I expect to see content "Phone Numbers: (612) 333-3333"
	  	And I expect to see a link to "Edit Customer"
	  	And I expect to see a link to "Delete Customer"
	  	And I expect to see a link to "Back to Business Page"
	  	When I click the "Back to Business Page" link
	  	Then I am at my business profile page


