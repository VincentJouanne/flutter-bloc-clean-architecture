
Feature: Sign up form checks and success
Background: 
    Given the dependencies are resolved
After:
    Then the dependencies are popped

    Scenario: email badly formatted
        Given An unknown user on the signup page
        When he enters a badly formatted email
        Then he should see an error message {'invalid email'}

    Scenario: email well formatted but password badly formatted
        Given An unknown user on the signup page
        When he enters a well formatted email
        But he enters a badly formatted password
        Then he should see two error messages {'invalid password'} {'passwords do not match'} 
    
    Scenario: confirmed password missing
        Given An unknown user on the signup page
        When he enters a well formatted email
        And he enters a well formatted password
       Then he should see an error message {'passwords do not match'} 

    Scenario: An unknown user is able to sign up with valid credentials
        Given An unknown user on the signup page
        And the user enters valid credentials
        When the user taps on the create account button
        Then the user see the login page

