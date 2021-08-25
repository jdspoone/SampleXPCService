/*

  Created by Jeff Spooner

*/

import Foundation


class XPCService : NSObject, NSXPCListenerDelegate, XPCServiceProtocol
  {

    var count : Int = 0
    let listener : NSXPCListener


    override init()
      {

        // Initialize an XPC listener using the XPC service's label
        // Please note that the label must be advertised in the service's launchd.plist
        listener = NSXPCListener(machServiceName: xpcServiceLabel)

        super.init()

        // Set the listener's delegate to be ourself
        listener.delegate = self
      }


    func start()
      {
        listener.resume()
      }


    func stop()
      {
        listener.suspend()
      }


    // MARK: NSXPCListenerDelegate

    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool
      {
        // Set the exported object of the new connection to be ourself
        newConnection.exportedObject = self

        // Specify the interface the exported object will conform to
        newConnection.exportedInterface = NSXPCInterface(with: XPCServiceProtocol.self)

        // New connection start in a suspended state and must be resumed
        newConnection.resume()

        // Always accept the incoming connection
        return true
      }


    // MARK: XPCServiceProtocol

    func incrementCount()
      {
        count += 1
      }


    func getCount(block: (Int) -> Void)
      {
        // Call the completion block with the current count
        block(count)
      }


  }
