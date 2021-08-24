/*

  Created by Jeff Spooner

 */

import Foundation


public let xpcLabel : String = "com.example.XPCService"

@objc protocol XPCServiceProtocol
  {
    func incrementCount() -> Void

    func getCount(block: @escaping (Int) -> Void) -> Void
  }
