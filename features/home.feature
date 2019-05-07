Feature: home page

  Scenario: Show the home page
    Given I am on the homepage
    When I press "Create an account" within "huge blue"
    When I press "Create an account" within "huge blue"
    When I press "Submit" within "form"
    Then I should see "Welcome"
    Then I should see "You logged into the member's area"