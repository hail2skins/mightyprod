Then(/^I expect to see a form to add a new service$/) do
  expect(page).to have_css(:form, "")
end

Then(/^I do not expect to see a link to "(.*?)"$/) do |link|
  expect(page).to_not have_link(link)
end