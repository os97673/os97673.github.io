+++
title = '"Proper" synchronization'
date = 2024-06-01T17:59:49Z
draft = false
+++

Recently, we had a discussion about the way synchronization is used in our code. In some cases, engineers synchronize all methods of the class even if all of them are bound to one thread (e.g., annotated with [@MainThread](https://developer.android.com/reference/androidx/annotation/MainThread)). Sometimes, the same object is used to synchronize both main thread and worker thread methods, which is dangerous since it may block the main thread for a long time (leading to ANRs). Additionally, excessive or improper use of synchronization may cause deadlocks. So, what would be the right use for synchronization?

It seems worthwhile to start with a reminder of why synchronization might be used:
1. To provide thread safety for data access. There is a lot of information about the Java Memory Model, so I will not repeat it here.
2. To ensure two code paths cannot be executed concurrently.

Let's start with the second use case. If you want to make sure that some code paths are executed sequentially, you could use a [single-threaded executor](https://developer.android.com/reference/java/util/concurrent/Executors#newSingleThreadExecutor()) or a [Handler](https://developer.android.com/reference/android/os/Handler). This way, you have the functionality you need but no locks to create problems :-)

For the first use case, there are several strategies:
1. Bind data to one thread (if you only use data from the same thread, then no synchronization is needed).
2. Use thread-safe data structures (e.g., atomic types instead of primitives, and concurrent/synchronized collections instead of regular ones, which are not thread-safe).
3. Limit the scope of synchronization to [@AnyThread](https://developer.android.com/reference/androidx/annotation/AnyThread) methods (which have to be quick by their definition) and, ideally, do not call any other methods from them to avoid nested locks (incorrect order of locking may lead to a deadlock).

Overall, synchronization is a complicated concept, so if you can avoid it, then please do so (less complexity means more reliable code).
