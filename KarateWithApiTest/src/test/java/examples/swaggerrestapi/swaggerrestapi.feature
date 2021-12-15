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
    And path 'pet/9223372000001084529/uploadImage'
    And request requestBody
    When method Post
    Then status 200