//
//  PasteAgent.m
//
//  Created by Daniel Dean on 12/7/16.
//

#import "PasteAgent.h"

static NSString* PAErrDomain = @"com.dhdean.pasteagent";

@implementation PasteAgent


//------------------------------------------------------------------------------
+ (NSURLTaskCallback)getCallback:(void (^)(NSString* pasteUrl, NSError* error))handler {
    return [PasteAgent getCallbackExpectingURLMatchingPrefix:nil handler:handler];
}


//------------------------------------------------------------------------------
+ (NSURLTaskCallback)getCallbackExpectingURLMatchingPrefix:(NSString*)prefix handler:(void (^)(NSString* pasteUrl, NSError* error))handler {
    return ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            handler(nil, error);
            return;
        }
        
        if (!data.length) {
            // Empty response body.
            handler(nil, [NSError errorWithDomain:PAErrDomain code:945731 userInfo:nil]);
        }
        
        NSString* responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!responseText.length) {
            // Response body isn't plain text.
            handler(nil, [NSError errorWithDomain:PAErrDomain code:945732 userInfo:@{@"responseBlob":data}]);
            return;
        }
        
        if (prefix.length && ![[responseText substringToIndex:prefix.length] isEqualToString:prefix]) {
            // Response doesn't contain a URL.
            handler(nil, [NSError errorWithDomain:PAErrDomain code:945733 userInfo:@{@"responseText":responseText}]);
            return;
        }
        
        handler(responseText, nil);
    };
}


@end
