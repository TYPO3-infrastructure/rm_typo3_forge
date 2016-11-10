Feature: Project Feature

  Scenario: I want to register a new project
    I have an idea for a new project and want to user forge to maintain it
    so i have to register it
    Given an active user "tester"
    And I am logged in as user "tester"
    And a toplevel project "extensions" is existing
    And I visit "/"
    When I click on "Register project"
    And I Fill "my_awesome_project" in the "project_name"
    And I Fill "my_awesome_project" in the "package_key"
    And I uncheck "create_repo"
    And I click on "Register Project"
    Then I will see "Take me to my_awesome_project"
