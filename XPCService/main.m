/*

  Created by Jeff Spooner

*/

#import <Foundation/Foundation.h>
#import "XPCService.h"


int main(int argc, const char *argv[])
  {
    // Create an instance of the XPC service and start it
    XPCService *service = [[XPCService alloc] init];
    [service start];

    // Enter a continuous loop
    dispatch_main();

    return 0;
  }
