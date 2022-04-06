Feature: Login failure
Background: 
    Given the dependencies are resolved with an error when logging in
After:
    Then the dependencies are popped

    Scenario: account disabled
    Given I am on the login page
    When I type {'vincent@gmail.com'} in the email text field of the login page
    And I type {'Password123'} in the password text field of the login page
    And I tap on the login button
    Then I should see a text {'This user has been disabled. Please contact support for help.'}

