Feature: Sign up

  Scenario: check the join feature no 1
    Given I am on the join page
    When I fill in "display_name" with "twitter"
    When I fill in "first_name" with "twitter"
    When I fill in "Surname" with "test"
    When I fill in "email" with "test@test.com"
    When I fill in "password" with "test" 
    When I press "Join" within "form"
    Then I should see "Order your taxi with a tweet."
  
  Scenario: check the join feature no 2
    Given I am on the join page
    When I fill in "display_name" with "twitter"
    When I fill in "first_name" with "twitter"
    When I fill in "Surname" with "test"
    When I fill in "email" with "test@test.com"
    When I fill in "password" with "test" 
    When I press "Join" within "form"
    Then I should not see "Sorry but it seems that email or Twitter name is incorrect...🤔"
    
  Scenario: check the Twitter handle
    Given I am on the join page
    When I fill in "display_name" with ""
    When I fill in "first_name" with "twitter"
    When I fill in "Surname" with "test"
    When I fill in "email" with "test@sheffield.ac.uk"
    When I fill in "password" with "test" 
    When I press "Join" within "form"  
    Then I should see "Order your taxi with a tweet."
    
  Scenario: check the First name & Twitter handle
    Given I am on the join page
    When I fill in "display_name" with ""
    When I fill in "first_name" with ""
    When I fill in "Surname" with "test"
    When I fill in "email" with "test@sheffield.ac.uk"
    When I fill in "password" with "test" 
    When I press "Join" within "form"  
    Then I should see "Order your taxi with a tweet."
    
  Scenario: check the Surname
    Given I am on the join page
    When I fill in "display_name" with "teitter"
    When I fill in "first_name" with "twitter"
    When I fill in "Surname" with ""
    When I fill in "email" with "test@sheffield.ac.uk"
    When I fill in "password" with "test" 
    When I press "Join" within "form"  
    Then I should see "Order your taxi with a tweet."
    
  Scenario: check the email
    Given I am on the join page
    When I fill in "display_name" with ""
    When I fill in "first_name" with "twitter"
    When I fill in "Surname" with "test"
    When I fill in "email" with ""
    When I fill in "password" with "test" 
    When I press "Join" within "form"
    Then I should see "Order your taxi with a tweet."

  Scenario: User already exists (email)
	Given I am on the join page
    When I fill in "display_name" with "test"
    When I fill in "first_name" with "test"
    When I fill in "Surname" with "test"
    When I fill in "email" with "test@sheffield.ac.uk"
    When I fill in "password" with "test"
	Then I should not see "Sorry but it seems that email or Twitter name is incorrect...🤔"

  Scenario: Logging out from the website
    Given I want to create an account
    Given I login as user
    Given I am on the homepage
    When I press "logout button"
    Then I should see "Order your taxi with a tweet."