+++
title = 'Java ThreadPoolExecutor'
date = 2025-01-11T19:10:28Z
draft = false
+++

[ThreadPoolExecutor](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ThreadPoolExecutor.html) is very convenient and powerful tool but has some nits, so let me write them down here (to have a place to find next time I need ;)

1. If you are using unbounded queue with the executor (by default) it will never go above core pool size (or one thread if core pool size is 0).  Because it only addes such threads if queue reject a new task being added.  There are several workarounds can be found on the Internet (e.g. use a custom queue which reject everything if it is not empty and custom [RejectedExecutionHandler](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/RejectedExecutionHandler.html) which will put the runnable to the queue on rejection)

2. While the ThreadPoolExecutor allows to change max thread pool (see [setMaximumPoolSize()](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/ThreadPoolExecutor.html#setMaximumPoolSize-int-)) it is only cancel idle threads if new limit is lower than the number of workers it has, and do not increase the workers count until you actually post a new job.  I.e. if you have a long queue of tasks and increase the max pool size it will still use the same workers it has.  To trigger creating new worker you need to submit somthing to
it and it looks like one submittion creates only one thread so you may need to submit several (empty?) jobs to get a new max thread count active.