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
    
    Scenario: check the Twitter handle
    Given I am on the join page
    When I fill in "display_name" with ""
    When I fill in "first_name" with "twitter"
    When I fill in "Surname" with "test"
    When I fill in "email" with "test@sheffield.ac.uk"
    When I fill in "password" with "test" 
    When I press "Join" within "form"
    
    Then I should see "Sorry"
    
     Scenario: check the First name & Twitter handle
    Given I am on the join page
    When I fill in "display_name" with ""
    When I fill in "first_name" with ""
    When I fill in "Surname" with "test"
    When I fill in "email" with "test@sheffield.ac.uk"
    When I fill in "password" with "test" 
    When I press "Join" within "form"
    
    Then I should see "Sorry"
    
     Scenario: check the Surname
    Given I am on the join page
    When I fill in "display_name" with "teitter"
    When I fill in "first_name" with "twitter"
    When I fill in "Surname" with ""
    When I fill in "email" with "test@sheffield.ac.uk"
    When I fill in "password" with "test" 
    When I press "Join" within "form"
    
    Then I should see "Sorry"
    
     Scenario: check the email
    Given I am on the join page
    When I fill in "display_name" with ""
    When I fill in "first_name" with "twitter"
    When I fill in "Surname" with "test"
    When I fill in "email" with ""
    When I fill in "password" with "test" 
    When I press "Join" within "form"
    
    Then I should see "Sorry"
    
    Feature: Signing up
	
	Scenario: User already exists (email)
	
		When I press "Sign Up"
		Then I should see "This user already exists in the system"

	Scenario: User already exists (twitter_handle)
	
		When I press "Sign Up"
		Then I should see "This user already exists in the system"

	Scenario: No email
		
		When I press "Sign Up"
		Then I should see "This is not a valid email"

	Scenario: Invalid email
	
		When I press "Sign Up"
		Then I should see "This is not a valid email"

	Scenario: Invalid password
	
		When I press "Sign Up"
		Then I should see "Password is too short"

	Scenario: Valid Passwords that Don't match
	
		When I press "Sign Up"
		Then I should see "Passwords do not match"

	Scenario: Signed up successfully
	
		When I press "Sign Up"
		Then I should see "You have successfully signed up. Please login with your credentials."




    
