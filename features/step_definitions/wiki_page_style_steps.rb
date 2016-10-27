Given(/^I am on the wiki Page of project "([^"]*)"$/) do |projectname|
  project = Project.find_by(name: projectname)
  visit project_wiki_path(project)
end

When(/^I click on "([^"]*)"$/) do |identifier|
  click_on(identifier)
end

When(/^I Fill "([^"]*)" in the "([^"]*)"$/) do |content, field|
  fill_in(field, with: content)
end

Then(/^I will not see "([^"]*)"$/) do |content|
  expect(page).not_to have_content(content)
end
