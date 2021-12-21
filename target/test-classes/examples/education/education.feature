Feature: SwaggerApiTest

  Background:
    * url 'https://petstore.swagger.io/v2/'
    * def requestBody =
        """
        {"id":0,"category":{"id":0,"name":"string"},"name":"doggie","photoUrls":["string"],"tags":[{"id":0,"name":"string"}],"status":"available"}
        """
    * def responseBody =
        """
      {"id":"#notnull","category":{"id":0,"name":"string"},"name":"doggie","photoUrls":["string"],"tags":[{"id":0,"name":"string"}],"status":"available"}
        """
  Scenario: Get Request
    And path '/store/inventory'
    When method Get
    Then status 200

  Scenario: Query parameters
    And path '/pet/findByStatus'
    And param status = 'available'
    When method Get
    Then status 200

  Scenario: Def operation ve post request
    And path '/pet'
    And request requestBody
    When method Post
    Then status 200
    And match response == responseBody

  Scenario Outline: Data table
    And path '/pet/findByStatus'
    And param status = <status>
    When method Get
    Then status 200
    Then print response
    Examples:
      | status |
      | 'available' |
      | 'pending' |
      | 'sold' |

  Scenario: Header ekleme
    And path '/pet'
    And request requestBody
    And header Content-Type = 'application/json'
    And header user-Agent = 'Testinium'
    When method Post
    Then status 200

  Scenario: Match Operatoru
    And path '/store/inventory'
    When method Get
    Then status 200
    Then match $.sold == 6
    Then match $.string == 132
    Then assert responseTime < 1000

  Scenario: Header ekleme
    * def requestBody = read('classpath:example.json')
    And path '/pet'
    And request requestBody
    And header Content-Type = 'application/json'
    And header user-Agent = 'Testinium'
    When method Post
    Then status 200

  Scenario: run function
    * def requestBody = read('classpath:example.json')
    * requestBody.name ='duman'
    * def myJSFun =
      """
      function(arg){
      return arg.length
      }
      """
    * def postedLength = call myJSFun requestBody.name
    And path '/pet'
    And request requestBody
    And header Content-Type = 'application/json'
    And header user-Agent = 'Testinium'
    When method Post
    * def responseLength = call myJSFun $.name
    Then match postedLength == responseLength