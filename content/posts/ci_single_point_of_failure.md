+++
title = 'CI is a trap?'
date = 2024-10-19T23:44:39Z
draft = false
+++

It is hard to imagine modern development environment without some
Continious integration pipeline (CI) and this is a huge helper for 
developers until it breaks. And at this moment you realize how much
you rely on it and how much resounces needs to be devoted to keep this 
system working.

<!--more-->

Here are couple problems you can have when CI doesn't work at all or
doesn't work the way it is supposed to work:
1. CI is dead and you cannot get any signals for changes devs landing
2. CI is broken but you don't know about it (e.g. your tests builds are failing but CI doesn't report these failures back)

For the first case you know that something is broken and "all hands on deck" to fix it.
For the second one - you don't know but relying on the signals from CI to report 
any problems.  E.g. you can land whatever you want and break something without 
even knowning.
For the the second case is terrifying for me.  And it is a big question to me:
how much resources should be spent to avoid such situations...
