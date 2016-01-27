Feature: Business creates notification
	In order to view communications with my customers
	my business should be able to view all customer notifications
	I can view a list and see each individual notification sent to business customers

	Background: Logging in with a business
	  Given I am logged in
	  And I have created one business
	  And I have created two customers
	  And I have created two notifications
	  Then I logout
    When I login with valid credentials

	  Scenario: Creating a service
	    Then I am at my business profile page
	    And I expect to see a link to "Contact Customers"
	    When I click the "Contact Customers" link
	    And I expect to see a link to "Notification history"
	    When I click the "Notification history" link 
	    Then I expect to see the title "Notification history"
	    And I expect to see content "Notification history"
	    And I expect to see content "Email Subject"
	    And I expect to see content "Date Sent"
	    And I expect to see a link to "Test this awesome e-mail"
      And I expect to see a link to "This is awesome too, huh"
      When I click the "Test this awesome e-mail" link
      Then I expect to see the title "Notification view"
      And I expect to see content "Email Subject:"
      And I expect to see content "Email Body:"
      And I expect to see content "Date Sent:"
      And I expect to see content "Test this awesome e-mail"
      And I expect to see content "This is the body of my awesome e-mail.   It is an awesome body."
      And I expect to see a link to "Return to main business page"
      And I expect to see a link to "Back to Customer Contact"

