Feature: Add Cars

	@addcarsheff
  	Scenario: Add standard car in Sheffield
  		When I login as admin
	    Given I am on the adminpage
	    When I press "Add_car"
	    Then I should see "Add car"

	@addcarmanc
  	Scenario: Add standard car in Manchester
	  	When I login as admin
	    Given I am on the adminpage
	    When I press "Add_car"
	    Then I should see "Add car"

	Scenario: Add car, no reg
		Given I am on the homepage
		When I login as admin
		When I follow "Add Cars"
		When I fill in "Status" with "0"
		When I fill in "Type" with "0"
		When I fill in "car_model" with "testmodel"
		When I press "Submit Car"
		Then I should see "Car Registration cannot be empty"

	Scenario: Add car, no model
		Given I am on the homepage
		When I login as super
		When I follow "Manage Cars"
		When I fill in "car_id" with "testid"
		When I fill in "car_make" with "testmake"
		When I fill in "car_colour" with "testcolour"
		When I press "Submit Car"
		Then I should see "Car Model cannot be empty"

	Scenario: Add car, no make
		Given I am on the homepage
		When I login as super
		When I follow "Manage Cars"
		When I fill in "car_id" with "testid"
		When I fill in "car_colour" with "testcolour"
		When I fill in "car_model" with "testmodel"
		When I press "Submit Car"
		Then I should see "Car Make cannot be empty"

	Scenario: Add car, no colour
		Given I am on the homepage
		When I login as super
		When I follow "Manage Cars"
		When I fill in "car_id" with "testid"
		When I fill in "car_make" with "testmake"
		When I fill in "car_model" with "testmodel"
		When I press "Submit Car"
		Then I should see "Car Colour cannot be empty"

	Scenario: Show all cars in different offices
		Given I am on the homepage
		When I login as super
		When I create a standard car in Manchester
		When I create a standard car in Sheffield
		When I follow "Manage Cars"
		When I press "Show All Cars"
		Then I should see "standardmanchester123"
		Then I should see "standardsheffield123"
		When I press "Show Sheffield Cars"
		Then I should see "standardsheffield123"
		Then I should not see "standardmanchester123"
		When I press "Show Manchester Cars"
		Then I should not see "standardsheffield123"
		Then I should see "standardmanchester123"