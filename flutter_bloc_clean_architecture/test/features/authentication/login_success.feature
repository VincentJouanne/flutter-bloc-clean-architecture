Feature: Login form checks and success
Background: 
    Given the dependencies are resolved
After:
    Then the dependencies are popped

    Scenario: email badly formatted
        Given I am on the {'login'} page
        When I enter {'some-invalid-email'} in the text field {'loginForm_emailInput_textField'}
        Then I should see a text {'invalid email'}

     