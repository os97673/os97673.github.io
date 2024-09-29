+++
title = 'Implicit Dependencies In The Code'
date = 2024-09-29T21:02:57Z
draft = false
+++

We have a function that can be executed using either a foreground service or WorkManager. Recently, I was tasked with changing how it runs for a particular case. Since the code was already designed to work with both WorkManager and foreground services, it seemed like it would be a simple change, right?

<!--more-->

Well, it turned out that even though the code was supposed to work correctly for both cases, there were several places where implicit assumptions were “leaking.” For example, we knew that the action wasn’t supposed to be triggered with WorkManager for this specific case, but the "glue" code handling it didn’t properly account for that scenario. In another instance, we mistakenly used the value of one parameter as a signal for another condition—these two parameters were linked before the change, but they no longer should have been. All tests were passing (before the change), because they wre testing all "realistic" scanarios ;-)

So, I’m leaving this note as a reminder for the future:
**be cautious when writing code to avoid introducing these kinds of “implicit” dependencies**. They can easily slip through and cause unexpected issues when making changes down the line.
