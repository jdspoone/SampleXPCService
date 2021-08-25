/*
    Created by Jeff Spooner
*/

import Foundation


let xpcServiceLabel = "com.example.XPCService"

@objc protocol XPCServiceProtocol
  {
    func incrementCount() -> Void

    func getCount(block: @escaping (Int) -> Void) -> Void
  }
