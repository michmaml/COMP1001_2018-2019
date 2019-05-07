Feature: log in

  Scenario: Correct password entered
    Given I am on the loginpage
    When I fill in "email" with "test@sheffield.ac.uk"
    When I fill in "password" with "test"
    When I press "Submit" within "form"
    Then I should see "Welcome"
    Then I should see "You logged into the member's area"
    
  Scenario

