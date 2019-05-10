Feature: Views Cars

    
  	Scenario: check all of the cars
  		
	    Given I am on the carspage
	    Then I should see "Seats"
      
      Scenario: The checkbox should not be selected by default
      
      As a developer
    I want to be able to test the selected state of a checkbox
    
      Given I am on the carspage
        Then I expect that checkbox "#checkbox" is not checked

      Scenario: check diferent seats cars
      
        Given I am on the carspage
        When I fill in the following "checkbox" whit "4"
        Then I shoud not see "cars.seats==5"
        
        Scenario: The checkbox should deselect when clicked twice
        Given I am on the carspage
        Given the checkbox "#checkbox" is not checked
        When  I click on the element "#checkbox"
        And   I click on the element "#checkbox"
        Then I expect that checkbox "#checkbox" is not checked
  	


	
 
	
	