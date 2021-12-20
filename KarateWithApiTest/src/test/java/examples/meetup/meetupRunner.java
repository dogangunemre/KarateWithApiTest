package examples.meetup;

import com.intuit.karate.junit5.Karate;

public class meetupRunner {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("meetup").relativeTo(getClass());
    }
}

