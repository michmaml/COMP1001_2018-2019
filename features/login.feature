Feature: log in

   
  Scenario: Correct password entered
    Given I am on the loginpage
    When I fill in "email" with "test@sheffield.ac.uk"
    When I fill in "password" with "test"
    When I press "Submit" within "form"
    Then I should see "Admin system"
@addtestaccount
  Scenario: Incorrect passoword entered
    Given I am on the loginpage
    When I fill in "email" with "delete@sheffield.ac.uk"
    When I fill in "password" with "NOTCORRECT"
    When I press "Submit" within "form"
    Then I should see "Not authorised"
    
  Scenario: Incorrect login entered
    Given I am on the loginpage
    When I fill in "email" with "NOTCORRECT"
    When I fill in "password" with "test"
    When I press "Submit" within "form"
    Then I should see "Not authorised"

  Scenario: Incorrect credentials entered
    Given I am on the loginpage
    When I fill in "email" with "NOTCORRECT"
    When I fill in "password" with "NOTCORRECT"
    When I press "Submit" within "form"
    Then I should see "Not authorised"