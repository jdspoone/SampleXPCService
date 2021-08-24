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
        ContentView().environmentObject(connectionManager)
      }
    }
    
  }
