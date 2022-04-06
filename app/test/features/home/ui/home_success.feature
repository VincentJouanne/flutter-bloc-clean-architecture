Feature: Home page
Background: 
    Given the dependencies are resolved and the user is authenticated
After:
    Then the dependencies are popped

    Scenario: disconnection
    Given I am on the home page
    When I tap on disconnect button
    Then I should be redirected to the login page
    