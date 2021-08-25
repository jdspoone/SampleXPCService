/*

  Created by Jeff Spooner

*/

import SwiftUI


struct ContentView: View {

  // The connection manager object is passed to the Content View as an Environment Object
  @EnvironmentObject var connectionManager: ConnectionManager


  var body: some View {
    Button("Get Count", action: getCount)
    Button("Increment Count", action: incrementCount)
  }


  var xpcService : XPCServiceProtocol
    {
      return connectionManager.connection().remoteObjectProxyWithErrorHandler { err in
        print(err)
      } as! XPCServiceProtocol
    }


  func getCount() -> Void
    {
      // Send a completion callback to the XPC service
      xpcService.getCount { count in
        print("xpcService count is \(count)")
      }
    }


  func incrementCount() -> Void
    {
      // Message the XPC service to increment it's counter
      xpcService.incrementCount()
    }

}
