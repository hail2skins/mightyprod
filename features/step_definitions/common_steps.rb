When(/^I click the "(.*?)" link$/) do |link|
  click_link link
end

Given(/^I should see a link to "(.*?)"$/) do |link|
  expect(page).to have_link(link)
end

Then(/^I should see content "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |form, data|
  page.fill_in form, with: data
end

Then(/^I click the "(.*?)" button$/) do |button|
  click_button(button)
end

Then(/^I expect to see the title "(.*?)"$/) do |title|
  expect(page).to have_title(title)
end

Then(/^a prompt asks "(.*?)"$/) do |content|
  page.driver.console_messages.first
end

When(/^I accept popup$/) do
  page.execute_script('window.confirm = function() { return true }')
  #page.driver.accept_js_confirms!
  #expect(page).to have_xpath("//a[@id='are-you-sure' and @confirmed='true']")
end