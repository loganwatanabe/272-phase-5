Feature: Manage students
  As an administrator
  I want to be able to manage student data
  So I can more effectively run the karate school

  Background:
    Given red and white belt students
  
  # READ METHODS
  Scenario: The student name in all students is a link to student details
    When I go to the students page
    And I click on the link "Minor, Howard"
    Then I should see "Minor, Howard"
    And I should see "Rank: Third Gup"
    And I should see "Waiver Signed: Yes"
    And I should see "Active: Yes"
    And I should not see "Gruberman"
    And I should not see "Noah"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created" 