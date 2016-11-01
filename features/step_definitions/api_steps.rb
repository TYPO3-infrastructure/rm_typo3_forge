Given(/^an private project "([^"]*)" is existing and belongs to "([^"]*)"$/) do |projectname, parent_project_name|
  Project.create(name: projectname, identifier: projectname, parent: Project.find_by(name: parent_project_name), is_public: false)
end
Given("check Step") do
  binding.pry
end

When(/^I send a (GET|PATCH|POST|PUT|DELETE) request (?:for|to) view "([^"]*)"(?: with the following:)? via service$/) do |*args|
  request_type = args.shift
  path = project_service_show_path(Project.find_by(name: args.shift).id)
  input = args.shift
  request_opts = {method: request_type.downcase.to_sym}
  unless input.nil?
    if input.class == Cucumber::MultilineArgument::DataTable
      request_opts[:params] = input.rows_hash
    else
      request_opts[:input] = StringIO.new input
    end
  end
  request path, request_opts
end

When(/^I send a (GET|PATCH|POST|PUT|DELETE) request (?:for|to) view members of "([^"]*)"(?: with the following:)?$/) do |*args|
  request_type = args.shift
  path = project_memberships_path(project_id: Project.find_by(name: args.shift).id) + ".#{@content_type}"
  input = args.shift
  request_opts = {method: request_type.downcase.to_sym}
  unless input.nil?
    if input.class == Cucumber::MultilineArgument::DataTable
      request_opts[:params] = input.rows_hash
    else
      request_opts[:input] = StringIO.new input
    end
  end
  request path, request_opts
end

Given /^I send and accept an (JSON|XML) API request$/ do |type|
  @content_type = type.downcase
  header 'Accept', "application/#{@content_type}"
  header 'Content-Type', "application/#{@content_type}"
end

When(/^I send a (GET|PATCH|POST|PUT|DELETE) request to view "([^"]*)" with "([^"]*)" "([^"]*)"(?: with the following:)$/) do | *args|
  request_type = args.shift
  class_name = args.shift
  attribute_name = args.shift
  attribute_value = args.shift
  path = send("#{class_name.downcase}_path", class_name.constantize.find_by(attribute_name.to_sym => attribute_value), format: @content_type)
  input = args.shift
  request_opts = {method: request_type.downcase.to_sym}
  unless input.nil?
    if input.class == Cucumber::MultilineArgument::DataTable
      if @api_key
        request_opts[:params] = input.rows_hash.merge({key: @api_key})
      else
        request_opts[:params] = input.rows_hash
      end
    else
      request_opts[:input] = StringIO.new input
    end
  end
  request path, request_opts
end

Given(/^the User "([^"]*)" is an Admin$/) do |username|
  user = User.find_by(login: username)
  user.admin = true
  user.save!
end

When(/^I authenticate as the user "([^"]*)" via api_key$/) do |username|
  @api_key = User.find_by(login: username).api_key
end
