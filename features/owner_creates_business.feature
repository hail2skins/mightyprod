Feature: Owner creates business
	In order to utilize the site to track my customers
	as a business owner I must create a business
	I want to be able to add a business when I am logged in

	Background: Loggin in
	  Given I am logged in
  	  And I am at my owner profile page

  	Scenario: Owner adds first business
	  And I should see content "Business Information"
	  And I should see content "You have not yet provided us information about your business."
	  And I should see a link to "Add your business now!"
  	  When I click the "Add your business now!" link
  	  Then I can see a form to add business information
  	  And I expect to see the title "Create a business"
  	  When I fill in "Business name" with "Test Business"
  	  And I fill in "Description" with "Aesthetics"
      And I fill in or select the category of my business
  	  And I click the "Submit my business information" button
  	  Then I should see content "Congratulations.  Your business has been created."
  	  And I am at my owner profile page
  	  And I should see content "Test Business"
  	  And I can see my "business name" in a link
      And I should see content "Services Information"
      And I should see content "we just need a little information about some of the services"
      And I should see a link to "Add a service your business provides now!"
  	  And I should see a link to "Add"
  	  When I click the "Add" link
  	  Then I can see a form to add business information
  	  And I expect to see the title "Create a business"
  	  When I fill in "Business name" with "Test Business 2"
  	  And I fill in "Description" with "Cool business"
  	  And I click the "Submit my business information" button
  	  Then I should see content "Congratulations.  Your business has been created."
  	  And I am at my owner profile page
  	  And I should see a link to "Test Business 2"