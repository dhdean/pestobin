//
//  PasteBinAgent.m
//
//  Created by Daniel Dean on 12/6/16.
//

#import "PastebinAgent.h"
#import "NSMutableURLRequest+PasteBin.h"

@interface PastebinAgent()

@property (nonatomic, strong) NSString* devAPIKey;

@end

@implementation PastebinAgent


//------------------------------------------------------------------------------
- (id)initWithAPIKey:(NSString*)key {
    if (!key) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _devAPIKey = key;
    }
    return self;
}


//------------------------------------------------------------------------------
- (void)paste:(NSString*)text handler:(void (^)(NSString* pasteUrl, NSError* error))handler {
    [self paste:text key:self.devAPIKey handler:handler];
}


//------------------------------------------------------------------------------
- (void)paste:(NSString*)text key:(NSString*)key handler:(void (^)(NSString* pasteUrl, NSError* error))handler {
    NSMutableURLRequest* request = [NSMutableURLRequest createPastebinPostWithText:text key:key];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            handler(nil, error);
            return;
        }
        
        if (!data.length) {
            // Empty response body.
            handler(nil, [NSError errorWithDomain:@"com.dhdean.pastebinagent" code:945731 userInfo:nil]);
        }
        
        NSString* responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!responseText.length) {
            // Response body isn't plain text.
            handler(nil, [NSError errorWithDomain:@"com.dhdean.pastebinagent" code:945732 userInfo:@{@"responseBlob":data}]);
            return;
        }
        
        NSString* match = @"http://";
        if (![[responseText substringToIndex:match.length] isEqualToString:match]) {
            // Response doesn't contain a URL.
            handler(nil, [NSError errorWithDomain:@"com.dhdean.pastebinagent" code:945733 userInfo:@{@"responseText":responseText}]);
            return;
        }
        
        handler(responseText, nil);
    }] resume];
}


@end
