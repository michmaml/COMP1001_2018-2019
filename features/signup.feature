Feature: Sign up

  Scenario: check the join feature
    Given I am on the join page
    When I fill in "display_name" with "twitter"
    When I fill in "first_name" with "twitter"
    When I fill in "Surname" with "test"
    When I fill in "email" with "test@sheffield.ac.uk"
    When I fill in "password" with "test"
    
    When I press "Join" within "form"
    Then I should see "Sorry"
