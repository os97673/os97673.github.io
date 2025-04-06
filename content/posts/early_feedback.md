+++
title = 'Early feedback'
date = 2025-04-06T23:20:41Z
draft = false
+++

I'm reading a book, [*Simplicity* by Dave Thomas](https://pragprog.com/titles/dtcode/simplicity/), and in the first chapter, the author suggests structuring your work with a fast feedback loop. I've been thinking about this and realized that recently I failed to do so — and the results weren’t great. 😕

<!--more-->

I've been working on fixing a problem we have with the proper encoding of file names we send to a third-party service. According to their API, the file name is part of the URL used to upload a file. Recently, we discovered issues with the encoding of certain file names. We had no visibility into the problem; it was reported and investigated by the service provider.

According to them, there was a mismatch between how we encode the file name in the URL and how they decode it. The obvious solution was to make sure we never send non-ASCII characters to avoid misunderstandings.

I implemented this change (which wasn’t trivial, as we needed to preserve all previously uploaded files as-is), but I failed to discuss the solution with the service’s maintainers. When we began rolling out this “trivial” fix, we discovered that the extra encoding we were applying made the URLs too long — so long that, for some users, they hit the service’s documented URL length limit (which I had completely forgotten about).

We paused the rollout and opened up a conversation with the other side. During this discussion, they realized they *do* perform URL decoding (handled by some middleware, so it wasn’t surprising they didn’t know this before). With this insight, they were able to identify the most problematic cases. Knowing these, I was able to pinpoint where in our code the incorrect encoding occurred.

As a result, the actual fix turned out to be much simpler than our original "smart" workaround. However, we now have some files encoded using the "new" method, so we’ll either need to maintain compatibility or re-upload them — a separate project altogether.

Looking back, if I had contacted them as soon as I suspected they were decoding URLs (even though they believed they weren’t), we could have saved time on developing the initial workaround and avoided runtime issues during rollout.

So, as hard as it is to admit, this one’s on me — for not re-checking things when I realized the situation was different from what we originally believed.

**Don’t forget: Orient. Step. Learn. 🙂**
