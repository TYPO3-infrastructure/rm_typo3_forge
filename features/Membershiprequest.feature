
Feature: Projectmembership Requests

  Background:
    Given an active user "test" with password "iwanttotest" is existing
    And a toplevel project "Tests" is existing
    And an project "testproject" is existing and belongs to "Tests"
    And an active user "owner" with password "iownthatproject" is existing
    And "owner" is in the project "testproject"

  @javascript
  Scenario: Request projectmembership
    A User want to request a membership for a project.
    Given I am logged in as user "test" with password "iwanttotest"
    And I am on the project page of "testproject"
    When I am submitting an membershiprequest
    Then I will see "We have received your request and will review it soon!"
