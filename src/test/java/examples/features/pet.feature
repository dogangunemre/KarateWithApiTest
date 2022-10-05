Feature: TTest

  Task 1: GET request and verify status, print response
  Task 2: POST request
  Task 3: POST with external JSON file
  Task 4: Scenario outline
  Task 5: Scenario Outline with CSV
  Task 6: Calling js function
  Task 7: Callers
  Task 8: Runners and Parallel runner
  Task 9: Gatling integration and Perf test
  Task 10: Added Header
  Task 11: Match Operator
  Task 12: Get all users and then get the first user by id
  Task 13: Create a user and then get it by id

  Background:
    Given  url swaggerurl
    And  path 'pet'
    * def requestBody =
        """
        {"id":0,"category":{"id":0,"name":"string"},"name":"doggie","photoUrls":["string"],"tags":[{"id":0,"name":"string"}],"status":"available"}
        """
    * def responseBody =
        """
      {"id":"#notnull","category":{"id":0,"name":"string"},"name":"doggie","photoUrls":["string"],"tags":[{"id":0,"name":"string"}],"status":"available"}
        """

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

  Scenario Outline: outline with csv - <number>
    And path number
    When method GET
    Then print response
    And status 200

    Examples:
      | read('examples/data/data.csv') |

  Scenario: custom js function
    * def myString = call read('classpath:examples/function/generate.js') 5
    * print myString

  Scenario: custom js function2
    * def myString = call read('classpath:examples/function/generate.js') 5
    * def myRequestBody = read('classpath:examples/data/pet.json')
    And set myRequestBody.name = myString
    And request myRequestBody
    When method POST
    Then status 200
    And print response

  Scenario: run function
    * def requestBody = read('classpath:example.json')
    * requestBody.name ='emre'
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
    When method Post
    * def responseLength = call myJSFun $.name
    Then match postedLength == responseLength

    Scenario: using callers
      * def myCaller = call read('classpath:examples/callers/demo.feature'){id:250}
    Then match myCaller.responseStatus == 200
    Then match myCaller.response.id == 250

  Scenario: Added Header
    * def myRequestBody = read('classpath:examples/data/pet.json')
    And path '/pet'
    And request myRequestBody
    And header Content-Type = 'application/json'
    When method Post
    Then status 200

  Scenario: Match Operator
    And path '/store/inventory'
    When method Get
    Then status 200
    Then match $.sold == 6
    Then match $.string == 132
    Then assert responseTime < 1000


  Scenario: Get all users and then get the first user by id
    Given url 'https://jsonplaceholder.typicode.com'
    Given path 'users'
    When method get
    Then status 200

    * def first = response[0]

    Given path 'users', first.id
    When method get
    Then status 200

  Scenario: Create a user and then get it by id
    * def user =
      """
      {
        "name": "Test User",
        "username": "testuser",
        "email": "test@user.com",
        "address": {
          "street": "Test Name",
          "suite": "Apt. 123",
          "city": "Test",
          "zipcode": "54321-6789"
        }
      }
      """

    Given url 'https://jsonplaceholder.typicode.com/users'
    And request user
    When method post
    Then status 201

    * def id = response.id
    * print 'created id is: ', id

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

