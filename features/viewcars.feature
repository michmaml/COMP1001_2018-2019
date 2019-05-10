Feature: Views Cars

    
  	Scenario: check all of the cars
  		
	    Given I am on the carspage
	    Then I should see "Seats"
      

      Scenario: check diferent seats cars
        Given I am on the homepage
        When I follow "Cars" 
        When I check "check_3"
        Then I am on the carspage
        
        Scenario: The checkbox should deselect when clicked twice
        Given I am on the carspage
        When I follow "Cars" 
        When I check "check_3"
        Then I am on the carspage
  	


	
 
	
	