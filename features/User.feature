Feature: User Feature

  Scenario: Find User by login
    I want to see the Profile Page of a registerd User via Login name
    Given an active user "tester"
    When I visit "users/tester"
    Then I will see "Test Run"
