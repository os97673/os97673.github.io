+++
title = 'Threading_annotations'
date = 2024-04-13T19:23:04Z
draft = false
+++

Android sdk introduces [threading annotations](https://developer.android.com/studio/write/annotations#thread-annotations), with commonly used ones such as 
[@MainThread](https://developer.android.com/reference/androidx/annotation/MainThread),
[@WorkerThread](https://developer.android.com/reference/androidx/annotation/WorkerThread),
and [@AnyThread](https://developer.android.com/reference/androidx/annotation/AnyThread),
at least in our codebase.

The official documentation syas: "Denotes that the annotated method should only be 
called on the XXX thread." This is clear when writing simple methods. However, the story
changes when dealing with threading annotations for methods of an interface or methods
intended for overriding in subclasses. It's not merely "can only be called" anymore, as
the implementer doesn't control where the method is called, but rather "will only be called" now.

Here are a few observed approaches:

1. [Choosing the annotation to simplify method implementations](#simplify-implementations-of-the-method)
2. [Selecting threading annotations to simplify caller's implementation](#to-simplify-callers-implementation)
3. [Using @AnyThread to disallow both UI and heavy operations](#to-disallow-both-ui-and-heavy-operations)

## Simplify Implementations of the Method

Most implementations benefit from ensuring that the method is called on a particular thread. For instance, if most methods modify UI elements, ensuring they are always called from the main thread simplifies implementation.

## To Simplify Caller's Implementation

In cases where there's no clear preferred thread (e.g., some implementations work with UI, while others handle heavy operations), enforcing a particular thread can complicate the caller's code.

## To Disallow Both UI and Heavy Operations

While less common, there are scenarios where it's necessary to restrict both UI and heavy operations. In our code, we sometimes enforce this restriction when methods are not called on the main thread, especially when handling incoming/outgoing data in separate threads. While it may seem like a hack to enforce this non-standard requirement with standard tools, it can be useful in certain contexts.
