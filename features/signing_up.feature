Feature: Signing Up	
	In order to track my customers and utilize the Mighty Smalls CMS
	As an owner of a business with customers
	I want to visit a page to sign up

	Background: Visiting the sign up page
		Given I am at the home page of the site

	  Scenario: Signing up
	  	When I click the "Sign up now!" link
	  	Then I expect to see the title "Sign up"
	  	And as a new "Owner" signing up there is a form to fill in my information
	  	And I click the "Create my account" button
	  	Then I should see content "Please open the link to activate your account."
	  	When I confirm my new email
	  	Then I am at the home page of the site
	  	When I click the "Login" link
	  	And I fill in "Email" with "test@test.com"
	  	And I fill in "Password" with "password"
	  	And I click the "Login" button
	  	Then I am at my owner profile page
	  	And I should be informed I need to add a business

	  Scenario: Checking the Login link
	  	And I should see a link to "Login"
	  	When I click the "Login" link
	  	Then I should see a form to login
	  	And I expect to see the title "Login"