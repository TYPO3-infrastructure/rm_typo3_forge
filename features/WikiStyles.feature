
Feature: Allow possibility to add CSS to Wiki Pages

Background:
  Given an active user "tester" with password "iwanttotest" is existing
  And a toplevel project "Tests" is existing
  And an project "testproject" is existing and belongs to "Tests"
  And an active user "owner" with password "iownthatproject" is existing
  And "owner" is in the project "testproject"

  @javascript
  Scenario: WikiPage Style
    In Forge Redmine there is a possibility to append_style to the wikipages
    Given I am logged in as user "owner" with password "iownthatproject"
    And I am on the wiki Page of project "testproject"
    Then I will see the "Styles" section
    When I Fill "h1. FooBar" in the "content_text"
    When I click on "Save"
    And I click on "Edit"
    And I click on "Styles"
    And I Fill "h1{display:none}" in the "style_text"
    And I click on "Save"
    Then I will not see "FooBar"
