Feature: Manage Stories
  In order to make a submission
  As an author
  I want to create and manage stories
  

  Scenario: Create story without logging in
    Given I am not logged in
    And I am on the list of stories
    When I follow "submit"
    Then I should be on the sign in page
  
  Scenario: Create valid story with title and URL
    Given I am logged in
    And I am on the list of stories
    When I follow "submit"
    Then I should be on the new story page
    And I fill in "story_title" with "woot"
    And I fill in "story_url" with "http://www.woot.com"
    And I press "submit"
    Then I should see a story created message

   Scenario: Create valid story with title and text
    Given I am logged in
    And I am on the list of stories
    When I follow "submit"
    Then I should be on the new story page
    And I fill in "story_title" with "Note 2"
    And I fill in "story_text" with "The best mobile in the world"
    And I press "submit"
    Then I should see a story created message

  Scenario: Create story with title, text and URL
    Given I am logged in
    And I am on the list of stories
    When I follow "submit"
    Then I should be on the new story page
    And I fill in "story_title" with "woot"
    And I fill in "story_text" with "The best mobile in the world"
    And I fill in "story_url" with "http://www.woot.com"
    And I press "submit"
    Then I should see the message "Cannot provide both text and url."

  Scenario: Create Story without title
    Given I am logged in
    And I am on the list of stories
    When I follow "submit"
    Then I should be on the new story page
    And I fill in "story_url" with "http://www.woot.com"
    And I press "submit"
    Then I should see a story not created message
