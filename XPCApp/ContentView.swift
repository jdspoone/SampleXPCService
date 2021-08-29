/*

  Created by Jeff Spooner

*/

import SwiftUI


struct ContentView: View {

  // The connection manager object is passed to the Content View as an Environment Object
  @EnvironmentObject var connectionManager: ConnectionManager


  var body: some View {
    Text(String(connectionManager.count)).padding()
    Button("Start Timer", action: startTimer).padding()
    Button("Cancel Timer", action: cancelTimer).padding()
  }


  var xpcService : XPCServiceProtocol
    {
      return connectionManager.connection().remoteObjectProxyWithErrorHandler { err in
        print(err)
      } as! XPCServiceProtocol
    }


  func startTimer() -> Void
    {
      // Message the XPC Service to begin the timer
      xpcService.startTimer()
    }


  func cancelTimer() -> Void
    {
      // Message the XPC service to cancel the timer
      xpcService.cancelTimer()
    }

}
