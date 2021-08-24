/*

  Created by Jeff Spooner

*/

import Foundation


class ConnectionManager: NSObject, ObservableObject
  {

    private var _connection: NSXPCConnection!


    override init()
      {
        // Create an XPC connection to the XPC service
        _connection = NSXPCConnection(serviceName: xpcServiceLabel)

        // Set the XPC interface of the connection's remote object using the XPC service's published protocol
        _connection.remoteObjectInterface = NSXPCInterface(with: XPCServiceProtocol.self)

        // New connections must be resumed before use
        _connection.resume()

        super.init()

        // Configure the XPC connection's interruption handler
        _connection.interruptionHandler = {

          // If the interruption handler has been called, the XPC connection remains valid, and the
          // the XPC service will automatically be re-launched with future calls to the connection object
          print("connection to XPC service has been interrupted")
        }

        // Configure the XPC connection's invalidation handler
        _connection.invalidationHandler = {

          // If the invalidation handler has been called, the XPC connection is no longer valid and must be recreated
          print("connection to XPC service has been invalidated")
        }
      }


    public func connection() -> NSXPCConnection
      { return _connection }

  }
