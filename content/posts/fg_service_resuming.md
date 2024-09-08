+++
title = 'Resuming foreground serive (Android)'
date = 2024-09-08
draft = false
+++

Suppose you have an operation that you are executing in a foreground service, which can only be performed once and you have an activity which controls the process. There is a possibility that the app might be killed or the managing activity re-created, and you would need to resume the operation. To do so, you need to call [ServiceCompat.startForeground()](https://developer.android.com/reference/androidx/core/app/ServiceCompat#startForeground(android.app.Service,int,android.app.Notification,int)) with an intent to restart the operation. 

<!--more-->

The challenge is that we don't know whether the service is still running (and performing the operation) or not. If the service is not running, sending the same intent would be safe. However, if the service is still running, you might end up queuing a second intent for the same operation.

One possible solution is to create a new intent specifically to "resume" the operation. The service would then need to check if the state is suitable for resumption, and if so, resume the operation; otherwise, it should ignore the request.

Of course the better one would be to have a view model to control the foreground process but it is not always possible with the old code you have to support.
