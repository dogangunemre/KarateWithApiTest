Feature: demo callers
  Scenario: demp scenario
    Given url swaggerurl
    And path 'pet', id
    When method GET
    Then print response

