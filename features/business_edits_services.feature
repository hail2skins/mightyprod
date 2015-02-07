Feature: Business edits services
	In order to manage the business services for my business
	as an owner of a business with services created
	I can edit a service

	Background: Logging in with a business
	  Given I am logged in
	  And I have created one business
	  And I have created two customers
	  And I have created two services
	  Then I logout
    When I login with valid credentials

	  Scenario: Editing services
	    Then I am at my business profile page
      When I click the "Number of services:" link
      Then I expect to see the title "Services for My Great Business"
      And I expect to see content "Services for My Great Business"
      And I expect to see content "Service name"
      And I expect to see content "Price"
      And I expect to see a link to "Microderm"
      When I click the "Microderm" link
      Then I expect to see a link to "Edit this service"
      When I click the "Edit this service" link
      Then I expect to see the title "Edit this service"
      And I expect to see content "Edit this service"
      And I expect to see content "Service name"
      And I expect to see content "Description"
      And I expect to see content "Price"
      When I fill in "Service name" with "Microderm Abrasian"
      And I fill in "Price" with "140"
      And I click the "Update Service" button
      Then I expect to see content "Service updated."
      And I am at my business profile page
      When I click the "Number of services:" link
      Then I expect to see content "Microderm Abrasian"
      And I expect to see content "$140"
      But I do not expect to see content "$125"