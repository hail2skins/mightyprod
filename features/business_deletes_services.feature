Feature: Business deletes services
	In order to manage the business services for my business
	as an owner of a business with services created
	I can delete a service which is no longer necessary

	Background: Logging in with a business
	  Given I am logged in
	  And I have created one business
	  And I have created two customers
	  And I have created two services
	  Then I logout
    When I login with valid credentials

	  Scenario: Deleting services
	    Then I am at my business profile page
      When I click the "Number of services:" link
      Then I expect to see the title "Services for My Great Business"
      When I click the "Microderm" link
      Then I expect to see a link to "Delete this service"
      When I click the "Delete this service" link
      Then I am at my business profile page
      And I expect to see content "Service deleted."
      When I click the "Number of services:" link
      Then I do not expect to see a link to "Microderm"