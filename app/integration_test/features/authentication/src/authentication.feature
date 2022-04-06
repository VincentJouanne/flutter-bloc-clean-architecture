Feature: Authentication
Background: 
  Given the dependencies are resolved and the app is running on a device

After:
    Then the dependencies are popped

    Scenario: signup
        Given I am on the signup page
        When I type {'vincent@gmail.com'} in the email text field of the signup page
        And I type {'Password123'} in the password text field of the signup page
        And I type {'Password123'} in the confirmed password text field of the signup page
        And I tap on the signup button
        Then I should be redirected to the home page
        And I tap on disconnect button
        Then I should be redirected to the login page
        And I type {'vincent@gmail.com'} in the email text field of the login page
        And I type {'Password123'} in the password text field of the login page
        And I tap on the login button
        Then I should be redirected to the home page
        







        
