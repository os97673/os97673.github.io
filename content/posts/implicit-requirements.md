+++
title = 'Implicit Code Requirements'
date = 2025-01-26T17:30:34Z
draft = false
+++

I recently modified some code to run a set of operations concurrently, replacing the single-threaded version we had before. The change itself was relatively simple, but testing revealed another issue. The operations relied on a statically stored object that is not thread-safe.

This object was located in a completely different part of the codebase and was used by methods within that class, which were in turn called by the modified code. The fix was straightforward (using `ThreadLocal` was sufficient in this case), but it made me realize that our codebase has many undocumented requirements and expectations (like this one).

Some might say this is a sign of "smelly code," and I wouldn’t disagree. However, this is the reality we’re working with, so I’m writing this down as a reminder:

1. Ensure your new code does not rely on undocumented requirements or expectations.
2. Even if a change seems simple, be prepared for it to break due to such hidden dependencies or assumptions.
