package performanceRunners

import scala.concurrent.duration.{Duration, SECONDS}

class UserSimulation extends Simulation{

  val myFirstLoadTest = scenario("my task").exec(karateFeature("classpath:examples/meetup/meetup.feature"))

  val protocol ={
    karateProtocol();
  }
 setup(
   myFirstLoadTest.inject(rampUsers(20) during (Duration(20,SECONDS))).protocols(protocol)
 )
}

//mvn clean test-compile gatling:test (enter)