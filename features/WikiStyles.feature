
Feature: Allow possibility to add CSS to Wiki Pages

  Scenario: WikiPage Style
    In Forge Redmine there is a possibility to append_style to the wikipages
    Given I am on the wiki Page of project "testproject"
    Then I will see the "Page Style" section
    When I click on "Page Style"
    And Fill "h1{display:none}" in the "style_text"
    And I click on "Save"
    Then I will not see "Wiki"
