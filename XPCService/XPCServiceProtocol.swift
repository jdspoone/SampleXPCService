/*

    Created by Jeff Spooner

*/

import Foundation


// Declare the XPC Service's label in file included in both the main app and XPC service
let xpcServiceLabel = "com.example.XPCService"


// A protocol declaring the exposed methods of the XPC service
@objc protocol XPCServiceProtocol
  {
    func incrementCount() -> Void

    func getCount(block: @escaping (Int) -> Void) -> Void
  }
