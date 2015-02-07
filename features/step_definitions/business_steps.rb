#Added for business_creates_customers.feature
Given(/^I have follow prompts to add a business$/) do
  create_business_form
end

Then(/^I expect to see content "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

Then(/^I expect to see a link to "(.*?)"$/) do |link|
  expect(page).to have_link(link)
end

Then(/^I expect to see a form to add customer information$/) do
  expect(page).to have_css('form', text: "")
end

Then(/^I expect to see a header with "(.*?)"$/) do |header|
  expect(page).to have_css('h1', header)
end

Then(/^I expect to not see content "(.*?)"$/) do |content|
  expect(page).to_not have_content(content)
end

Then(/^I expect the page to have a table$/) do
  expect(page).to have_selector('table')
end

#added for business_shows_customers.feature
Given(/^I have created two customers$/) do
  create_two_customers
end

#added for business_edits_customers.feature
Then(/^I expect to see a form to edit information$/) do
  expect(page).to have_css('form', text: "")
end

Then(/^I am at the new visit for customer page$/) do
  expect current_path == new_customer_visit_path(@customer)
end

Then(/^I expect to see a form to add package$/) do
  expect(page).to have_css('form', text: "")
end

Then(/^I do not expect to a link to "(.*?)"$/) do |link|
  expect(page).to_not have_link(link)
end

When(/^I select date from "(.*?)" date selector$/) do |select|
  page.select 'October', from: "#{select}_date_purchased_2i"
  page.select '24', from: "#{select}_date_purchased_3i"
  page.select '2014', from: "#{select}_date_purchased_1i"
end

Then(/^I am at my business package show page$/) do
  @package = @business.packages.first
  expect current_path == business_package_path(@business, @package)
end

Then(/^I am at the new package page$/) do
  expect current_path == new_business_package_path(@business)
end