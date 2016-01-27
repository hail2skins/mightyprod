Feature: Business creates notification
	In order to communicate with my customers
	my business should be able to write a customer notification
	I can create as an owner to send to business customers

	Background: Logging in with a business
	  Given I am logged in
	  And I have created one business
	  And I have created two customers
	  Then I logout
    When I login with valid credentials

	  Scenario: Creating a service
	    Then I am at my business profile page
	    And I expect to see a link to "Contact Customers"
	    When I click the "Contact Customers" link
	    Then I expect to see the title "Contact Customers"
	    And I expect to see content "Contact Customers"
	    And I expect to see a form to contact customers
	    And I expect to see content "Email subject"
	    And I expect to see content "Email body"
	    And I expect to see a link to "Back to main business page"
	    When I fill in "Email subject" with "Test email to customers"
	    And I fill in "Email body" with "This is a mail to tell you I love you."
	    Then I click the "Create Notification" button
	    Then I am at my business profile page
	    And I expect to see content "Notification sent to selected customers."

	    