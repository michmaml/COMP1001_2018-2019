Feature: Add Cars

	
  	Scenario: Add standard car in Sheffield
  		
	    Given I am on the adminpage
	    When I select "Add cars"
	    Then I should see "Car types:"

	
  	Scenario: Add standard car in Manchester
        Given I am on the adminpage
	     When I follow "Add cars"
	    Then I should see "Car types:"

	Scenario: Add car and print the values
		Given I am on the addcarpage
		When I fill in "Status" with "0"
		When I fill in "Type" with "0"
		When I fill in "Seats" with "5"
        When I fill in "Location" with "sheffiled"
        
		When I press "Submit"
		Then I should see "Seats"

	
	