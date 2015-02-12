Feature: Owner shows business service created
	In order to see and edit my business or businesses
	as a business owner who has a business and has created services
	I should be able to see details about my services created on my main business page

	Background: Log in and create business
	  Given I am logged in
	  And I have created one business
	  And I have created two services
    Then I logout
    When I login with valid credentials
  	
  	Scenario: Showing my business page
      Then I am at my business profile page
      And I expect to see a link to "Number of services:"
      And I expect to see content "Number of services: 2"
      