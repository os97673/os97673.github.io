+++
title = 'Performance logging for a multi-stage process'
date = 2024-04-28T17:00:38Z
draft = false
+++

So, there was this question floating around in one of the channels I frequent: When our process does its prep work and sets up an async job to fetch data from a server, should we log how long it takes for the prep and the job separately, or just lump it all together from start to finish?

The immediate thought might be: "Well, since users only see results once the job's done, let's just log it all as one to make sure their experience is smooth." But, here's the catch: with that kind of logging, we'll end up with this tricky phase "from job scheduled to job started," and:
1. **Time's a Rollercoaster:** That chunk of time could swing wildly.
2. **Hands Tied:** We might not be able to do much about it if the scheduler, say, is managed by the OS.

So, it's the classic "depends" situation:
- If you've got control over the scheduler or it's reliable, go ahead and track the whole process.
- But, if the scheduler's unpredictable and out of your control, focus on timing each step separately and add them up for your metric.
