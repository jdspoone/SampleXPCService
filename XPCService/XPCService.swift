/*

  Created by Jeff Spooner

*/

import Foundation


class XPCService : NSObject, NSXPCListenerDelegate, XPCServiceProtocol
  {

    var timerSource : DispatchSourceTimer?


    // The XPC Service must maintain an XPC listener to manage incoming XPC connections
    let listener : NSXPCListener

    // Maintain a reference to the XPC connection for communicating with the client application
    var connection : NSXPCConnection?


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
      { listener.resume() }


    func stop()
      { listener.suspend() }


    var clientApp : ClientProtocol
      {
        return connection!.remoteObjectProxyWithErrorHandler { err in
          print(err)
        } as! ClientProtocol
      }


    // MARK: NSXPCListenerDelegate

    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool
      {
        // Set the exported object of the new connection to be ourself
        newConnection.exportedObject = self

        // Specify the interface the exported object will conform to
        newConnection.exportedInterface = NSXPCInterface(with: XPCServiceProtocol.self)

        // Set the XPC interface of the connection's remote object using the client app's protocol
        newConnection.remoteObjectInterface = NSXPCInterface(with: ClientProtocol.self)

        // New connection start in a suspended state and must be resumed
        newConnection.resume()

        // Retain a reference to the new connection for use later
        connection = newConnection

        // Always accept the incoming connection
        return true
      }


    // MARK: XPCServiceProtocol

    func startTimer()
      {
        // Ensure that the timer source hasn't been created yet
        guard timerSource == nil else { return }

        // Create the timer source
        let source = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)

        // Schedule the timer source to fire every 2 seconds
        source.schedule(deadline: DispatchTime.now(), repeating: .seconds(2))

        // Set the event handler of the timer source to message to client app to increment it's count
        source.setEventHandler(handler: DispatchWorkItem(block: {
          self.clientApp.incrementCount()
        }))

        // Dispatch sources are created in a suspended state, and must be resumed before they begin processing events
        source.resume()

        // Retain the timer source
        timerSource = source
      }


    func cancelTimer()
      {
        // Ensure the timer source is non-nil
        guard timerSource != nil else { return }

        // Cancel and deallocate the timer source
        timerSource!.cancel()
        timerSource = nil
      }

  }
