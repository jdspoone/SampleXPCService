/*

  Created by Jeff Spooner

*/

#import <Foundation/Foundation.h>


static NSString *xpcServiceLabel = @"com.example.XPCService";

@protocol XPCServiceProtocol

- (void) incrementCount;

- (void) getCount:(void(^)(int count))completionCallback;

@end
