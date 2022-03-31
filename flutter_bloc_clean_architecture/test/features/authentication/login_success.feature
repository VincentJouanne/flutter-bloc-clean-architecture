Feature: Login form checks and success
Background: 
    Given the dependencies are resolved
After:
    Then the dependencies are popped

    Scenario: email badly formatted
        Given I am on the login page
        When I type {'some-invalid-email'} in the email text field of the login page
        Then I should see a text {'invalid email'}
    
    Scenario: password badly formatted
        Given I am on the login page
        When I type {'vincent@gmail.com'} in the email text field of the login page
        And I type {'pass'} in the password text field of the login page
        Then I should see a text {'invalid password'}

    Scenario: login with credentials successfull
        Given I am on the login page
        When I type {'vincent@gmail.com'} in the email text field of the login page
        And I type {'Password123'} in the password text field of the login page
        And I tap on the login button
        Then I should be redirected to the home page

    Scenario: login with google successfull
        Given I am on the login page
        And I tap on the login with google button
        Then I should be redirected to the home page
    
    Scenario: going to signup page from login
        Given I am on the login page
        And I tap on the create account button
        Then I should be redirected to the signup page
    
    