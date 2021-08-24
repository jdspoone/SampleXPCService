/*

  Created by Jeff Spooner

*/

#import "XPCService.h"


@interface XPCService () <NSXPCListenerDelegate, XPCServiceProtocol>

@property (nonatomic, strong, readwrite) NSXPCListener *listener;
@property (nonatomic, readwrite) BOOL started;

@property (nonatomic, readwrite) int count;

@end


@implementation XPCService

- (id) init
  {
NSLog(@"initializing xpc service");

    // Initialize an XPC listener using the XPC service's label
    // Please note that the label must be advertised in the launchd.plist
    _listener = [[NSXPCListener alloc] initWithMachServiceName:xpcServiceLabel];

    // Set the listener's delegate to be ourself
    _listener.delegate = self;

    // Initialize the remaining properties
    _started = NO;
    _count = 0;

    return self;
  }


- (void) start
  {
NSLog(@"starting xpc service");

    // Sanity check
    assert(_started == NO);

    // Begin listening for incoming XPC connections
    [_listener resume];

    _started = YES;
  }


- (void) stop
  {
NSLog(@"stopping xpc service");

    // Sanity check
    assert(_started == YES);

    // Stop listening for incoming XPC connections
    [_listener suspend];

    _started = NO;
  }


#pragma mark - XPCServiceProtocol

- (void) incrementCount
  {
    // Incrememnt the counter
    _count++;
  }


- (void) getCount:(void (^)(int))completion
  {
    // Pass the count back in the completion block
    completion(_count);
  }


#pragma mark - NSXPCListenerDelegate

- (BOOL) listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection
  {
NSLog(@"incoming connection");

    // Sanity checks
    assert(listener == _listener);
    assert(newConnection != nil);

    // Set the exported object of the new connection to be ourself
    newConnection.exportedObject = self;

    // Specify the interface the exported object with conform to
    newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCServiceProtocol)];

    // New connections start in a suspended state and must be resumed
    [newConnection resume];

    // Always accept the incoming connection
    return YES;
  }

@end
