Feature: Manage Comments
  As an author
  I want to create comments
  

  Scenario: Comments List
    Given I am logged in
    And I am on the home page
    When I follow "comments"
    Then I go to the list of new comments

