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
