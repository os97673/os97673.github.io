+++
title = 'CI is a trap?'
date = 2024-10-19T23:44:39Z
draft = false
+++

It’s hard to imagine a modern development environment without some form of continuous integration (CI) pipeline. CI is a tremendous help for developers—until it breaks. At that moment, you realize just how much you rely on it and how many resources are needed to keep the system running smoothly.

<!--more-->

Here are a few problems that can arise when CI isn’t working at all or isn’t functioning as expected:

1. CI is completely down, and you don’t receive any signals about changes developers are making.
2. CI is broken, but you don’t know about it (e.g., your test builds are failing, but CI isn’t reporting these failures).

In the first scenario, you’re aware that something is wrong, and it’s an "all hands on deck" situation to get things fixed. In the second case, you’re unaware of the problem, relying on CI to catch issues, while you could be landing changes that break things without even knowing it.

The second scenario is particularly frightening to me. It raises an important question: how much effort and resources should be dedicated to preventing such situations?
