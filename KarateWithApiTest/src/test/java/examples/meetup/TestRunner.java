package examples.meetup;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

//@RunWith(Karate.class)
//public class TestRunner {
//
//}

//@RunWith(Karate.class)
//@KarateOptions(
//        tags = "@regression"
//)
//public class TestRunner {
//}

@RunWith(Karate.class)
@KarateOptions(
        tags = "@smoke"
)
public class TestRunner {
}
