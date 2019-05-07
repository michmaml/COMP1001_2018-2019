Feature: contact

  Scenario: Sending email
    Given I am on the contactpage
    When I fill in "firstName" with "test"
    When I fill in "email" with "test@test.test"
    When I fill in "subject" with "test"
    When I fill in "message" with "test"
    When I press "Submit" within "form"
    Then I should see "Email sent 🎉🥰" 
