Feature: Creating Galleries
  In order to show photos on the site
  As a Contractor
  I want to create galleries

  Scenario: Contractor creates gallery
    Given I am a Contractor
    When  I create a gallery
    Then I am taken to the gallery edit page

  Scenario: Add photo to gallery
    Given I am a logged in Contractor
    And I am on the Gallery edit page
    When I add a new Photo
    Then Gallery will have one more Photo


  Scenario: Delete photo from gallery

  Scenario: Delete gallery
