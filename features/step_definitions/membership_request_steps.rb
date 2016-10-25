Given(/^an active user "([^"]*)" with password "([^"]*)" is existing$/) do |login, password|
  u = User.new
  u.login = login
  u.mail = "#{login}@example.org"
  u.firstname = "Test"
  u.lastname = "Run"
  u.password = password
  u.save!
  u.activate!
end

Given(/^"([^"]*)" is in the project "([^"]*)"$/) do |login, projectname|
  project = Project.find_by(name: projectname)
  user = User.find_by(login: login)
  role = Role.create(name: "Leader")
  members = []
  member = Member.new(:project => project, :user => user)
  member.role_ids = [role.id]
  members << member
  project.members = members
end

Given(/^a toplevel project "([^"]*)" is existing$/) do |projectname|
  Project.create(name: projectname, identifier: projectname)
end

Given(/^an project "([^"]*)" is existing and belongs to "([^"]*)"$/) do |projectname, parent_project_name|
  Project.create(name: projectname, identifier: projectname, parent: Project.find_by(name: parent_project_name))
end

Given(/^I am logged in as user "([^"]*)" with password "([^"]*)"$/) do |login, password|
    login_as(login, password)
    expect(page).to have_content login
end

Given(/^I am on the project page of "([^"]*)"$/) do |projectname|
  project = Project.find_by(name: projectname)
  visit project_path(project)
end

When(/^I am submitting an membershiprequest$/) do
  click_on('Join Project')
  fill_in('description', with: "I want to Help")
  click_on("Submit team membership request")
end

Then(/^I will see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end
