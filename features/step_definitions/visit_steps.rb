Then(/^I expect to see the checkbox checked$/) do
  expect(page).to have_field('Is this a special deal visit?', checked: true)
end

Then(/^I expect to see the checkbox unchecked$/) do
  expect(page).to have_field('Is this a special deal visit?', checked: false)
end