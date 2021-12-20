Feature: MeetupTest

  Task 1: GET request and verify status, print response
  Task 2: POST request
  Task 3: POST with external JSON file
  Task 4: Scenario outline
  Task 5: Scenario Outline with CSV
  Task 6: Calling js function
  Task 7: Callers
  Task 8: Runners and Parallel runner
  Task 9: Gatling integration and Perf test

  Background:
    Given  url swaggerurl
    And  path 'pet'

  Scenario: get request and status
    And  path 250
    When method GET
    Then print response
    And status 200

  Scenario: Post request with data
    * def mybody =
    """
    {
  "id": 1,
  "category": {
    "id": 0,
    "name": "string"
  },
  "name": "doggie",
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": "string"
    }
  ],
  "status": "available"
}
    """
    And request mybody
    When method POST
    Then karate.log(response)
    Then print response
    And match response.id == '#number'
    And match response.id == '#notnull'
    And match response.name == mybody.name

  Scenario: external JSON
    And def myRequestBody = read('classpath:examples/data/pet.json')
    And request myRequestBody
    When method POST
    Then status 200
    And match response.id == '#present' //id varmi
    And match response.name == myRequestBody.name
    And match response.category contains {"name" : "#string", "id" : "#number"}
    And match response contains {category : {"name" : "#string", "id" : "#number"}}

  Scenario Outline: outline basics
    * print id

    Examples:
      | id  |
      | 250 |
      | 251 |
      | 252 |

  Scenario Outline: outline basics2 <id>
    And path id // <id> //"<id>"
    When method GET
    Then print response

    Examples:
      | id  |
      | 250 |
      | 251 |
      | 252 |

  Scenario Outline: outline with csv - <number>
    And path number
    When method GET
    Then print response
    And status 200

    Examples:
      | read('examples/data/data.csv') |

  Scenario: custom js function
    * def myString = call read('classpath:examples/meetup/generate.js') 5
    * print myString

  Scenario: custom js function2
    * def myString = call read('classpath:examples/meetup/generate.js') 5
    * def myRequestBody = read('classpath:examples/data/pet.json')
    And set myRequestBody.name = myString
    And request myRequestBody
    When method POST
    Then status 200
    And print response

    Scenario: using callers
      * def myCaller = call read('classpath:examples/callers/demo.feature'){id:250}
    Then match myCaller.responseStatus == 200
Then match myCaller.response.id == 250

  @regression
  Scenario: using callers regression
    * def myCaller = call read('classpath:examples/callers/demo.feature'){id:250}
    Then match myCaller.responseStatus == 200
    Then match myCaller.response.id == 250

  @regression @smoke
  Scenario: using callers regression and smoke
      * def myCaller = call read('classpath:examples/callers/demo.feature'){id:250}
    Then match myCaller.responseStatus == 200
Then match myCaller.response.id == 250

  @smoke
  Scenario: using callers smoke
      * def myCaller = call read('classpath:examples/callers/demo.feature'){id:250}
    Then match myCaller.responseStatus == 200
Then match myCaller.response.id == 250