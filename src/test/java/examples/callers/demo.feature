Feature: demo callers
  Scenario: demoo scenario
    Given url swaggerurl
    And path 'pet', id
    When method GET
    Then print response

