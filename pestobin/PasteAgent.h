//
//  PasteAgent.h
//
//  Created by Daniel Dean on 12/7/16.
//

#import <Foundation/Foundation.h>

typedef void (^NSURLTaskCallback)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);
typedef void (^PasteAgentURLCallback)(NSString* _Nullable pasteUrl, NSError* _Nullable error);

@interface PasteAgent : NSObject

+ (NSURLTaskCallback _Nullable)getCallbackExpectingURLMatchingPrefix:(NSString* _Nullable)prefix handler:(PasteAgentURLCallback _Nullable)handler;

@end
