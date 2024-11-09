+++
title = 'Test is your enemy'
date = 2024-11-09
draft = false
+++

Unit tests are incredibly useful, and it's hard to imagine a world without them now—but they can also become your enemies. Tests need to be tightly coupled with the code they test, so each time you change that code, there’s a high chance you’ll need to modify the tests as well.

This is expected, but sometimes the way we write tests makes them even more tightly coupled, which can make changes harder.

For example, we often mock dependencies, including only what’s necessary to make the test work. However, this creates an implicit dependency. (What happens if, in a new version, you decide to call a different method?) We may also want to verify which methods are called and how many times. This, too, becomes another dependency that may not hold in future versions.

So, each time you write a test, be careful. Try to keep configurations as generic as possible, verifying only what truly needs verification (e.g., do you really need to check how many times a getter is called? 😉).
