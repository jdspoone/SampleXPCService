/*

  Created by Jeff Spooner

*/

import SwiftUI


@main
struct XPCApp: App
  {

    var connectionManager = ConnectionManager()

    var body: some Scene {
      WindowGroup {
        // Pass the connection manager to the content view as an environment object
        ContentView().environmentObject(connectionManager)
      }
    }
    
  }
