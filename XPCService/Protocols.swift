/*

    Created by Jeff Spooner

    XPC connections are bidirectional, meaning that while the main application can call
    methods on the XPC service through its XPC connection, the XPC service can also call
    methods on the on the main application through its XPC connection.

    Only those methods declared in the appropriate protocol, which is subsequently used to
    create the XPC interface, can be called through the XPC connection.

*/

import Foundation


// Declare the XPC Service's label in file included in both the main app and XPC service
let xpcServiceLabel = "com.example.XPCService"


// A protocol declaring the exposed methods of the XPC service
@objc protocol XPCServiceProtocol
  {

    func startTimer() -> Void

    func cancelTimer() -> Void

  }


// A protocol declaring the exposed methods of the client application
@objc protocol ClientProtocol
  {

    func incrementCount() -> Void

  }
