package examples.swaggerrestapi;

import com.intuit.karate.junit5.Karate;

public class swaggerrestapiRunner {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("swaggerrestapi").relativeTo(getClass());
    }
}
