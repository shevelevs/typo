Feature: Merge Articles
  As an admin
  In order to fix duplicate articles submitted by 2 different authors
  I want to merge articles

Background: users and articles have been added to database
  Given the blog is set up
  And the following users exist:
  | login           | email  | password | profile       | 
  | contributor     | email1 | aaaaaaaa | contributor   |
  | publisher       | email2 | aaaaaaaa | publisher     |
  And the following articles exist:
  | title           | body              | author        |
  | Article 1       | Article body1     | contributor   |
  | Article 2       | Article body2     | contributor   |
  | Article 3       | Article body3     | publisher     |

  Scenario: Merge articles form shown for admins
    Given I am logged in as "admin"
    And I am on the article edit page for "Article 1"
    Then I should see "Merge Articles"
    And I should see "Article ID" field
    And I should see "Merge" button

  Scenario: Merge articles form not shown for new articles
    Given I am logged in as "admin"
    And I am on the new article page
    Then I should not see "Merge Articles"

  Scenario: Merge articles form not shown for contributors
    Given I am on the article edit page for "Article 1"
    And I am logged in as "contributor"
    Then I should not see "Merge Articles"

  Scenario: Merge articles form not shown for publishers
    Given I am on the article edit page for "Article 1"
    And I am logged in as "publisher"
    Then I should not see "Merge Articles"

  Scenario: A non-admin cannot merge two articles
    Given I am on the article edit page for "Article 1"
    And I am logged in as "publisher"
    Then I should not see "Merge Articles"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged in as "admin"
    And I am on the article edit page for "Article 1"
    And I merge with "Article 2"
    Then article body should contain "Article body1"
    And  article body should contain "Article body2"
