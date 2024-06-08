+++
title = 'Resuming foreground serive'
date = 2024-06-08T22:26:06Z
draft = true
+++

Suppose you have an operation you are executing on a foreground service  which can only be executed once.  There is a possibility that the app will be killed/managing activity re-created and you'd need to resume the operation.  To do so you need to call startForegroundSerive() with an intent describing the operation.  The prroblem is that we don't know if the service is still running (and performing the operation) or not.  If the former then sending the same intent would be safe, but if the latter you would end up with the second intent for the same operation in the queue.  Thus you can to "invent" a new intent would indicate "resume" and when processing it check if we are in state which allow resume or the operation has been completed already (in such case the intent should be ignored).