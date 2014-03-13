Feature: Ending Campaigns
  In order to complete my campaign
  As a User
  I end my campaign

  Scenario: Campaign is funded
    Given an active Project
    When Project the project is funded
    Then An email should be sent to the Project User
    And They should be prompted to end their Project

  Scenario: User Ends Campaign

  Scenario: User donates remaining funds to Compassion

  Scenario: User adds more vendors to meet increased goal amount

