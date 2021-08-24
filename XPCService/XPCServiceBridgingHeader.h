/*

  Created by Jeff Spooner

  An Objective-C bridging header must be used to allow the Swift portion of this project to access necessary code written in Objective-C, in this case the XPC Service Protocol.

  In addition to the relevant header files being declared in this header file, you must also declare the Objective-C Bridging Header in:
    XPCApp target -> Build Settings -> Swift Compiler - General -> Objective-C Bridging Header

*/

#import "XPCServiceProtocol.h"
