package com.intelligentcat.parkwithyoubackend.controller;

import org.junit.Assert;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest
@RunWith(SpringRunner.class)
public class TestControllerTest {
    @Test
    public void should_test_passed() {
        Assert.assertEquals(3, 1 + 2);
    }

    @Test
    public void should_test_failed() {
        Assert.assertEquals(4, 1 + 2);
    }
}
