/*

  Created by Jeff Spooner

*/

import Foundation


class ConnectionManager: NSObject, ObservableObject, ClientProtocol
  {

    private var _connection: NSXPCConnection!

    // Since the count is being displayed in the ContentView, it must be a Published variable
    @Published var count : Int = 0


    override init()
      {
        // Create an XPC connection to the XPC service
        _connection = NSXPCConnection(serviceName: xpcServiceLabel)

        // Set the XPC interface of the connection's remote object using the XPC service's published protocol
        _connection.remoteObjectInterface = NSXPCInterface(with: XPCServiceProtocol.self)

        // New connections must be resumed before use
        _connection.resume()

        super.init()

        // In order to achieve bidirectional communication between the client app and the XPC service, we must
        //  additionally set the exported object and exported interface of the connection we have just created.
        _connection.exportedObject = self
        _connection.exportedInterface = NSXPCInterface(with: ClientProtocol.self)

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


    // MARK: ClientProtocol

    func incrementCount()
      {
        // Because this method is updating a Published variable, but will be called on a background thread,
        // We need to ensure that the logic to modify the count is run on the main thread
        DispatchQueue.main.async { self.count += 1 }
      }

  }
