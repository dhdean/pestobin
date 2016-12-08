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
    [PastebinAgent paste:text key:self.devAPIKey handler:handler];
}


//------------------------------------------------------------------------------
+ (void)paste:(NSString*)text key:(NSString*)key handler:(void (^)(NSString* pasteUrl, NSError* error))handler {
    NSMutableURLRequest* request = [NSMutableURLRequest createPastebinPostWithText:text key:key];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:[self getCallbackExpectingURLMatchingPrefix:@"http://" handler:handler]] resume];
}


//------------------------------------------------------------------------------
+ (void)getOutputForPaste:(NSString*)urlString handler:(void (^)(NSString* pasteUrl, NSError* error))handler {
    NSMutableURLRequest* request = [NSMutableURLRequest createPastebinOutputWithURLString:urlString];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:[self getCallback:handler]] resume];
}

@end
