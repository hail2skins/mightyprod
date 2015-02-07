Feature: Business shows services
	In order to manage the business services for my business
	as an owner of a business with services created
	I can view each specific service or list of services

	Background: Logging in with a business
	  Given I am logged in
	  And I have created one business
	  And I have created two customers
	  And I have created two services
	  Then I logout
    When I login with valid credentials

	  Scenario: Viewing a list of services then a single service
	    Then I am at my business profile page
      When I click the "Number of services:" link
      Then I expect to see the title "Services for My Great Business"
      And I expect to see content "Services for My Great Business"
      And I expect to see content "Service name"
      And I expect to see content "Price"
      And I expect to see a link to "Microderm"
      And I expect to see a link to "Facial"
      And I expect to see content "$125"
      And I expect to see content "$49.95"
      And I expect to see a link to "New Service"
      When I click the "Microderm" link
      Then I expect to see the title "Microderm service details"
      And I expect to see content "Microderm service details"
      And I expect to see content "Service name:"
      And I expect to see content "Description:"
      And I expect to see content "Price"
      And I expect to see a link to "New Service"
      And I expect to see a link to "Back to service index"
      And I expect to see a link to "Back to main business page"