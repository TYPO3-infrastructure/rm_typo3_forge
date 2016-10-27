Feature: API

  Background:
    Given an active user "tester" with password "iwanttotest" is existing
    And a toplevel project "Tests" is existing
    And an project "testproject" is existing and belongs to "Tests"
    And an private project "private_test_project" is existing and belongs to "Tests"
    And an active user "owner" with password "iownthatproject" is existing
    And "owner" is in the project "testproject"


  Scenario: Project Service List all Public Projects
    Check if the ProjectService list all public Project
    and Only the public ones
    When I send and accept JSON
    And I send a GET request to "/services/projects"
    Then the response status should be "200"
    And the JSON response should have "$..name" with the text "Tests"
    And the JSON response should have "$..name" with the text "testproject"
    And the JSON response should have "$..name" with a length of 2

    Scenario: Project Service show detail Public Projects
      Check if the ProjectService show information public Project
      When I send and accept JSON
      And I send a GET request to view "testproject" via service
      Then the response status should be "200"
      And the JSON response should have "$..members..user..login" with the text "owner"
      And the JSON response should have "$..name" with the text "testproject"
      And the JSON response should have "$..roles"

    Scenario: User Service show information of users
      Check if User Service returns image as full acceptable json
      When I send and accept JSON
      And I send a GET request to "services/users/active"
      Then the response status should be "200"
      And the JSON response should have "$..login" with the text "tester"
      And the JSON response should have "$..firstname" with the text "Test"
      And the JSON response should have "$..lastname" with the text "Run"
      And the JSON response should have "$..issue_count"
      And the JSON response should have "$..issue_count" with a length of 1
