//
//  PasteBinAgent.h
//
//  Created by Daniel Dean on 12/6/16.
//

#import <Foundation/Foundation.h>

@interface PastebinAgent : NSObject

- (id)initWithAPIKey:(NSString*)key;

- (void)paste:(NSString*)text handler:(void (^)(NSString* pasteUrl, NSError* error))handler;

- (void)paste:(NSString*)text key:(NSString*)key handler:(void (^)(NSString* pasteUrl, NSError* error))handler;


@end
