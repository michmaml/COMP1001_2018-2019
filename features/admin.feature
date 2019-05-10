Feature: Admin system

  Scenario: Logging out from admin page/not correct
    Given I am on the adminpage
    When I press "Log in" 
    Then I should not see "Order your taxi with a tweet."
    
  Scenario: Moving from login to signup
    Given I am on the loginpage
    When I press "signup" 
    Then I should see "Sign up"
  
  Scenario: Moving from signup to login
    Given I am on the signuppage
    When I press "loginbtn" 
    Then I should see "Log in"   
  
        
  	

	
 
	
	