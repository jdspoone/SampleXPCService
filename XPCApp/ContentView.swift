/*

  Created by Jeff Spooner

*/

import SwiftUI


struct ContentView: View {

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
      xpcService.getCount { count in
          print("xpcService count is \(count)")
        }
    }


  func incrementCount() -> Void
    {
      print("incrementing count")
      xpcService.incrementCount()
    }

}
