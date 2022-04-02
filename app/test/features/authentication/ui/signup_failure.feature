Feature: Sign up fails
Background: 
    Given the dependencies are resolved with an error when signing up
After:
    Then the dependencies are popped

    Scenario: An unknown user has entered valid credentials but his mail address has beed disabled
        Given I am on the signup page
        And I type {'vincent@gmail.com'} in the email text field of the signup page
        And I type {'Password123'} in the password text field of the signup page
        And I type {'Password123'} in the confirmed password text field of the signup page
        And I tap on the signup button
        Then I should see a text {'This user has been disabled. Please contact support for help.'}
        

        
