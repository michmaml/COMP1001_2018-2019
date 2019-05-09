Feature: notauthorised

  Scenario: Working back button
    Given I am on the notauthorised page
    When I press "Back"
    Then I should see "Sign up"