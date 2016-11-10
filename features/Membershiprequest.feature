
Feature: Projectmembership Requests

  Background:
    Given an active user "tester"
    And a toplevel project "Tests" is existing
    And an project "testproject" is existing and belongs to "Tests"
    And an active user "owner"
    And "owner" is in the project "testproject"

  @javascript
  Scenario: Request projectmembership
    A User want to request a membership for a project.
    Given I am logged in as user "tester"
    And I am on the project page of "testproject"
    When I am submitting an membershiprequest
    Then I will see "We have received your request and will review it soon!" in "want-to-help"
