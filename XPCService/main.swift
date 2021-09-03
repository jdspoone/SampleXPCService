/*

  Created by Jeff Spooner

  Please note, we're using Grand Central Dispatch for our run loop and not RunLoop
  because we have previously set the Info.plist value for RunLoopType to be
  dispatch_main, with the other option being NSRunLoop. The value specified in the
  Info.plist must match the method called at the end of the XPC service's main file

*/


import Foundation

// Create and start an instance of the XPC Service
let xpcService = XPCService()
xpcService.start()

// Run the XPC service on the main queue
dispatchMain()
