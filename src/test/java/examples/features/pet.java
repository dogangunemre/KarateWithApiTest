package examples.features;

import com.intuit.karate.junit5.Karate;

public class petsRunner {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("pet").relativeTo(getClass());
    }
}

