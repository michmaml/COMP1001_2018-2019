Feature: Views Cars

	
  	Scenario: check all of the cars
  		
	    Given I am on the carspage
	    Then I should see "Seats"
      
      Scenario: check diferent seats cars
      
        Given I am on the carspage
        When I fill in the following "checkbox" whit "4"
        Then I shoud not see "cars.seats==5"
  	


	
 
	
	