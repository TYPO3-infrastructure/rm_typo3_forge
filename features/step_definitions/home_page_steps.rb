Given(/^I am on the root page$/) do
  visit home_path
end

Then(/^I will see the "([^"]*)" section$/) do |arg1|
  expect(page).to have_content arg1
end
