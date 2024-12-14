+++
title = 'Usage of RequiresApi in a library api'
date = 2024-09-15T21:23:01Z
draft = false
+++

I've been looking into WorkManager's API (specifically, [ListenableWorker](https://developer.android.com/reference/androidx/work/ListenableWorker)) and noticed a number of methods marked with [@RequiresApi](https://developer.android.com/reference/androidx/annotation/RequiresApi). This was a surprise to me, as the library is intended to be used across as many Android versions as possible. This made me wonder why this is the case.

<!--more-->

The only reason I could come up with is that the authors of the library are using the annotation to indicate that these methods cannot be implemented on lower API levels. This is a valid reason, but as an app developer, it seems a bit too heavyweight. To make my code efficient (and to enable pre-verification), I can't simply write:

```kotlin
if (Build.VERSION.SDK_INT >= 31) {
    getStopReason()
}
```

Instead, I have to write something like:

```kotlin
if (Build.VERSION.SDK_INT >= 31) {
    Api31Utils.getStopReason(this)
}

// ...

@RequiresApi(31)
object Api31Utils {
    fun getStopReason(worker: ListenableWorker): Int {
        return worker.getStopReason()
    }
}
```

As an Android developer, I would prefer these methods to return a special result to indicate that the method is a no-op or cannot be supported on the current OS version.

I haven't spent time considering if this approach is possible for all such methods in the class, so it's entirely possible that some methods can't be handled this way. The point of this post is not to point fingers at anyone at Google but to jot down this thought so I don't forget it if I encounter similar situations while writing my APIs in the future. 
