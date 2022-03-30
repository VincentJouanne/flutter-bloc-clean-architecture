Feature: Login form checks and success
Background: 
    Given the dependencies are resolved
After:
    Then the dependencies are popped

    Scenario: email badly formatted
        Given I am on the login page
        When I type {'some-invalid-email'} in the email text field of the login page
        Then I should see a text {'invalid email'}
        

     