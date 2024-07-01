+++
title = 'Extension functions in Kotlin'
date = 2024-06-30
draft = false
+++

Recently we had a discussion when it is ok to use extension functions in Kotlin?
Here is what CahtGPT "thinks" about the topic:

> Extension functions in Kotlin are a powerful feature that allows you to add new functionality to existing classes without modifying their source code. However, like any powerful feature, they should be used judiciously. Here are some guidelines on when to use extension functions and when to avoid them:
>
> ### When to Use Extension Functions
>
> 1. **Enhancing Existing Classes**: Use extension functions to add functionality to existing classes, especially when you do not have control over the class's source code (e.g., classes from third-party libraries).
>
> 2. **Utility Functions**: They are ideal for adding utility functions that operate on instances of a class. For example, adding a `toJson()` method to any class to convert it to a JSON string.
>
> 3. **Code Readability**: When an extension function makes the code more readable and expressive. For example, adding a `isValidEmail()` function to the `String` class can make email validation code much cleaner.
>
> 4. **Separation of Concerns**: Use them to separate concerns by keeping utility or helper functions out of the primary class definition.
>
> 5. **Kotlin Standard Library**: Many of the Kotlin standard library functions are implemented as extensions, providing a more idiomatic Kotlin experience.
>
> ### When to Avoid Extension Functions
>
> 1. **Confusion with Regular Functions**: If the extension function can be confused with a member function, it can lead to ambiguity and confusion. This is especially true if an extension function has the same name as a member function.
>
> 2. **Dependency on Implementation Details**: Avoid using extension functions if they rely heavily on the internal details of the class they are extending. If the class implementation changes, the extension function might break.
>
> 3. **Limited Visibility**: Extension functions do not have access to private or protected members of the class they are extending. If your functionality requires access to such members, it's better to use a member function.
>
> 4. **Overuse**: Overusing extension functions can lead to a cluttered namespace and make the code harder to maintain. Use them judiciously and prefer them for well-scoped, clearly defined enhancements.
>
> 5. **Performance Considerations**: Although generally not an issue, be aware that extension functions are essentially static methods. If performance is a critical concern, especially in tight loops or performance-critical code, consider the potential overhead.
>
> 6. **Context-Specific Logic**: If the logic is highly specific to a particular context or requires access to multiple class members and state, it's often better to implement it as a member function or within the class itself.

While it is a great summary, it looks rather abstract to me. The main problem I see with extension functions is that they are too "subjective": different people may expect different things under the same name. While `toJson()` is more or less universally expected to return a JSON representation, others may not be so obvious.

For example, with `forEach()`, we do expect it to perform the same operation on each element of a collection. But what if the collection is actually a stream/cursor (which has been partially read)? Should it try to go back to the beginning of the stream/cursor and operate on all elements from the very beginning, or should it just proceed from the current position?

Another question is how the method should behave in terms of additional safety checks. Is it expected that the method will not crash when some pre-condition is not met? Back to the `forEach()` example: suppose we define it as "process all elements from the current position." Should it still check if we have already reached the end of the line (EOL) for the stream/cursor or not? Unfortunately, there is no right or wrong answer here: there are some valid reasons to perform all checks (e.g., "it is a generic method and it shouldn't fail on valid data") and to skip all checks ("this is a sugar to avoid code duplication when processing the stream/cursor, and all these checks are redundant extra work in most cases"). And since there is no definitive answer, people may (and will) interpret it differently.

Thus we have: on one hand, extension methods should be "common" enough to avoid writing your own DSL, but on the other hand, common names applied to slightly different entities may create uncertainty about expected behavior, which will be "hidden" by the fact it is a "common" name. A newcomer may assume they know what to expect.

The conclusion is simple (and similar to AI's): "with great power comes great responsibility," and before using this feature, think twice.
