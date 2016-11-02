Given(/^an active user "([^"]*)" with password "([^"]*)" is existing$/) do |login, password|
  visit register_path
  fill_in("user_login", with: login)
  fill_in("user_password", with: "#{login}#{login}")
  fill_in("user_password_confirmation", with: "#{login}#{login}")
  fill_in("user_mail", with: "#{login}@example.org")
  fill_in("user_firstname", with: "Test")
  fill_in("user_lastname", with: "Run")
  click_on("Submit")
  @current_user = User.find_by(login: login)
  @current_user.activate!
  @current_user.update_attributes(img_hash: "Empty")
end

Given(/^"([^"]*)" is in the project "([^"]*)"$/) do |login, projectname|
  user = User.find_by(login: login)
  role = Role.create(name: "Leader", permissions:
  [:view_master_backlog,
   :view_taskboards,
   :subscribe_to_calendars,
   :view_scrum_statistics,
   :add_messages,
   :view_calendar,
   :view_files,
   :view_gantt,
   :view_issues,
   :add_issues,
   :manage_issue_relations,
   :add_issue_notes,
   :edit_own_issue_notes,
   :move_issues,
   :save_queries,
   :view_issue_watchers,
   :add_issue_watchers,
   :browse_repository,
   :view_changesets,
   :view_time_entries,
   :view_wiki_pages,
   :view_wiki_edits,
   :edit_wiki_pages,
   :edit_wiki_styles])
  project = Project.find_by(name: projectname)
  members = []
  member = Member.new(:project => project, :user => user)
  member.role_ids = [role.id]
  members << member
  project.members = members
  logout
end

Given(/^a toplevel project "([^"]*)" is existing$/) do |projectname|
  login_as(@current_user.login, "#{@current_user.login}#{@current_user.login}")
  @current_user.admin = true
  @current_user.save
  @current_user.reload
  visit new_project_path
  fill_in("project_name", with: projectname)
  fill_in("project_identifier", with: projectname.downcase)
  click_on("Create")
end

Given(/^an project "([^"]*)" is existing and belongs to "([^"]*)"$/) do |projectname, parent_project_name|
  Project.create(name: projectname, identifier: projectname, parent: Project.find_by(name: parent_project_name))
end

Given(/^I am logged in as user "([^"]*)" with password "([^"]*)"$/) do |login, password|
    login_as(login, "#{login}#{login}")
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
