+++
title = 'Challenges Arising from Using CALLS_REAL_METHODS as the Default Answer for a Mock"'
date = 2024-02-25T21:34:36Z
draft = false
+++

Recently I've been converting Java utility class to Kotlin and after the convertion some unit tests started to time out on CI. After some investigation I've found the problematic code whick looks like
{{<highlight kotlin>}}
useMockStatic(MyUtils::class.java, CALLS_REAL_METHODS) { mockedStatic ->
  mockedStatic
      .whenever<Any> { MyUtils.loadFiles(eq(obj), any(), any()) }
      .thenReturn(fileList)
{{</highlight>}}

The first issue was relatively straightforward to identify: the second parameter was nullable, and Kotlin's `any()` function does not match `null` values. This discrepancy led to the replacement of `any()` with `anyOrNull()`.

Please note: `eq()` and `any()` were originally Java matchers (`org.mockito.ArgumentMatchers`) and are now Kotlin versions due to the inability to use Java's `any()` for non-null parameters.

The second issue proved more intriguing: when used in conjunction with `eq()`, the test became stuck within `whatever()`, while with `any()`, it functioned flawlessly. Through debugging, the discrepancy was pinpointed: although `any()` is declared to return a non-null value, it does, in fact, return `null`. Conversely, `eq()` returns a non-null value. Notably, when the static mock is created with `CALLS_REAL_METHODS`, calling a method within `whenever()` prompts `Mockito` to execute real methods with the provided parameters. Consequently, supplying null for a non-null argument results in a `NullPointerException`, which `Mockito` silently swallows, allowing execution to proceed and permitting the definition of a return value for the mock. However, when a non-null value is provided, the method undergoes execution, potentially leading to significant time delays and timeouts.

Various solutions exist for this problem, but the chosen approach is to refrain from using `CALLS_REAL_METHODS` for mocking and explicitly specify which methods should be called.

{{<highlight kotlin>}}
useMockStatic(MyUtils::class.java, defaultAnswer = notStubbedAnswer) {
    myUtils ->
  myUtils
      .whenever<Any> { MyUtils.method1(any()) }
      .thenCallRealMethod()
  myUtils
      .whenever<Any> {
        MyUtils.method2(anyOrNull(), anyOrNull(), any(), any())
      }
      .thenCallRealMethod()
  myUtils
      .whenever<Any> {
        MyUtils.loadFiles(eq(obj), anyOrNull(), any())
      }
      .thenReturn(fileList)
{{</highlight>}}
 

*Note: I've defined the custom default answer (which throws exceptions) to simplify detection of missed methods.*

{{<highlight kotlin>}}
private val notStubbedAnswer: (InvocationOnMock) -> Any = { _: InvocationOnMock ->
  throw UnsupportedOperationException("not stubbed")
}
{{</highlight>}}
