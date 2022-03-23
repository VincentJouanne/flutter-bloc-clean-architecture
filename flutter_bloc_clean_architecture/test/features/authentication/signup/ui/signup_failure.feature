Feature: Sign up fails
Background: 
    Given the dependencies are resolved with an error when signing up

    Scenario: An unknown user has entered valid credentials but his address mail has beed disabled
        Given An unknown user on the signup page
        And the user enters valid credentials
        When the user taps on the create account button
        Then he should see an error message {'This user has been disabled. Please contact support for help.'}
