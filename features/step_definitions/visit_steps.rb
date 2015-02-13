Then(/^I expect to see the checkbox checked$/) do
  expect(page).to have_field('This is a package deal', checked: true)
end

Then(/^I expect to see the checkbox unchecked$/) do
  expect(page).to have_field('This is a package deal', checked: false)
end