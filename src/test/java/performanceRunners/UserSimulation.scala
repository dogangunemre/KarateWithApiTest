package performanceRunners

import com.intuit.karate.gatling.PreDef.{karateFeature, karateProtocol}
import io.gatling.core.Predef.{Simulation,openInjectionProfileFactory, rampUsers, scenario}
import scala.concurrent.duration.{Duration, SECONDS}

class UserSimulation extends Simulation{

  val myFirstLoadTest = scenario("my task").exec(karateFeature("classpath:examples/meetup/meetup.feature"))

  val protocol = {
    karateProtocol()
  }
setUp(
  myFirstLoadTest.inject(rampUsers(20)during(Duration(20,SECONDS))).protocols(protocol)
)
}

//mvn clean test-compile gatling:test (enter)