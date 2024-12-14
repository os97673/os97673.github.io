+++
title = 'Nobody knows how to work with Unicode'
date = 2024-12-14T18:34:07Z
draft = false
+++

Of course, most people know how to convert text from one encoding to another, and this post isn’t about that. The real issue is that we often forget that **different encodings still exist**.
<!--more-->
Recently, we encountered a problem caused by the incorrect handling of localized strings. This reminded me that even in Ruby (a language developed in Japan), encoding was platform-specific for a long time. Because of this, Ruby faced the same issues as other languages developed by English-speaking communities.

Nowadays, many languages use UTF as the default encoding, which helps eliminate many of these problems. However, issues can still arise when different services or applications communicate with each other.

### Key Takeaway

Always remind yourself of potential encoding differences whenever you work with strings.
