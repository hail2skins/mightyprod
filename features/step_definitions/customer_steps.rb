When(/^I click the "(.*?)" link inside the table$/) do |click|
  within "#customers" do
    click_link("0", match: :first)
  end
end

Then(/^I expect to see a form to add a new visit$/) do
  expect(page).to have_css('form', text: "")
end

Then(/^I select date from date selector$/) do
  page.select 'October', from: "visit_date_of_visit_2i"
  page.select '24', from: "visit_date_of_visit_3i"
  page.select '2014', from: "visit_date_of_visit_1i"
end

Then(/^I am at my customer show page$/) do
  @customer = Customer.find_by_first_name("Art")
  expect current_path == business_customer_path(@business, @customer)
end

Then(/^I expect to see a form to edit visit$/) do
  expect(page).to have_css('form', text: "")
end

When(/^I select "(.*?)" from "(.*?)"$/) do |option, select|
  select(option, from: select)
end

Then(/^I do not expect to see content "(.*?)"$/) do |content|
  expect(page).to_not have_content(content)
end

Then(/^I expect to see today's date$/) do
  expect(page).to have_content(Date.today.strftime("%m/%d/%Y"))
end

Then(/^I check "(.*?)"$/) do |option|
  check(option)
end

When(/^I uncheck "(.*?)"$/) do |option|
  uncheck(option)
end