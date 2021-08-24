/*

  Created by Jeff Spooner

*/

#import <Foundation/Foundation.h>
#import "XPCServiceProtocol.h"


@interface XPCService : NSObject <XPCServiceProtocol>

- (id) init;

- (void) start;
    // Begin listening for incoming XPC connections

- (void) stop;
    // Stop listening for incoming XPC connections

@end
