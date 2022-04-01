
Feature: Sign up form checks and success
Background: 
    Given the dependencies are resolved
After:
    Then the dependencies are popped

    Scenario: email badly formatted
        Given I am on the signup page
        When I type {'invalid-email'} in the email text field of the signup page
        Then I should see a text {'invalid email'}

    Scenario: email well formatted but password badly formatted
        Given I am on the signup page
        When I type {'vincent@gmail.com'} in the email text field of the signup page
        And I type {'pass'} in the password text field of the signup page
        Then I should see a text {'invalid password'} 
        Then I should see a text {'passwords do not match'} 

    Scenario: confirmed password missing
        Given I am on the signup page
        When I type {'vincent@gmail.com'} in the email text field of the signup page
        And I type {'Password123'} in the password text field of the signup page
        Then I should see a text {'passwords do not match'}

    Scenario: An unknown user is able to sign up with valid credentials
         Given I am on the signup page
        When I type {'vincent@gmail.com'} in the email text field of the signup page
        And I type {'Password123'} in the password text field of the signup page
        And I type {'Password123'} in the confirmed password text field of the signup page
        And I tap on the signup button
        Then I should be redirected to the home page

