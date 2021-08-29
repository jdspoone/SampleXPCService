#  ReadMe

This Xcode projects demonstrates simple XPC communication between an application and an XPC service.

The project includes:
* A main application with a user interface, 
* An XPC service embedded within the main application

To use this application:
* Build and Run the XPCApp target
* Use the *Start Timer* button to launch a timer on the XPC service which will trigger the client's *count* variable to be incremented on firing
* Use the *Cancel Timer* button to cancel the XPC service's timer 

The XPC Service is launched automatically alongside the main application, and terminates when the main application terminates.

Please refer to Apple's [Daemons and Services Programming Guide](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingXPCServices.html#//apple_ref/doc/uid/10000172i-SW6-SW1)  for a more in-depth discussion of this topic.
