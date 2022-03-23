Feature: Sign up
Background: 
    Given the dependencies are resolved
    Scenario: An unknown user is able to sign up with valid credentials
    Given An unkown user on the signup page
    And the user enters valid credentials
    When the user taps on the create account button
    Then the user see the login page