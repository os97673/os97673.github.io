+++
title = 'Better Way To Mock Cursors In Tests'
date = 2024-02-11T00:36:30Z
draft = false
+++

When you mock [Cursor](https://developer.android.com/reference/android/database/Cursor)
you either have to mock all methods (which is painful) or mock only methods you
need in the implementation and this adds unneeded dependency (find a better term)
between test and production code.  It is better to use [MatrixCursor](https://developer.android.com/reference/android/database/MatrixCursor) which a
complete Cursor’s implementation which will  behaves as a regular Cursor which has
the data you need.
When return MatrixCursor make sure you return a new instance every time.
Something like:
{{<highlight kotlin>}}
whenever(database.query()).thenAnswer {
    MatrixCursor(arrayOf("id", "name")).apply {
        addRow(arrayOf(1, "John"))
        addRow(arrayOf(2, "Doe"))
    }
}
{{</highlight>}}
