Feature: home page

  Scenario: Show the home page
    Given I am on the homepage
    When I press "Create an account" 
    Then I should see "Sign up"
    
   Scenario: Press log in button
    Given I am on the home page
    When I press "Log in"
    Then I should see "Log in"
    
   Scenario: Show the join page
    Given I am on the home page
    When I press "Sign up" 
    Then I should see "Sign up"
   
   Scenario: Show the contact page
    Given I am on the home page
    When I press "Contact us" 
    Then I should not see "We are here to help. 😁"
    