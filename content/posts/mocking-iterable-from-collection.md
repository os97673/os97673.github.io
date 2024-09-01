+++
title = 'Mocking Iterable From Collection'
date = 2024-09-01T23:00:50Z
draft = false
+++

Sometimes you may need to mosk iterator-lick object from a given collection.
Here is a simple code snapshot for this:

<!--more-->

{{<highlight kotlin>}}
mock<Iterator<T>>().apply {
    data.fold(whenever(hasNext())) { stubbing, _ -> 
        stubbing.thenReturn(true)
    }.thenReturn(false)
    data.fold(whenever(next())) { stubbing, f -> 
        stubbing.thenReturn(f)
    }
}
{{</highlight>}}
