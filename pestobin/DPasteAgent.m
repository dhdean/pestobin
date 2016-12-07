//
//  DPasteAgent.m
//
//  Created by Daniel Dean on 12/7/16.
//

#import "DPasteAgent.h"
#import "NSMutableURLRequest+DPaste.h"

@implementation DPasteAgent


//------------------------------------------------------------------------------
+ (void)paste:(NSString*)text handler:(void (^)(NSString* pasteUrl, NSError* error))handler {
    NSMutableURLRequest* request = [NSMutableURLRequest createDPastePostWithText:text];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:[self getCallbackExpectingURLMatchingPrefix:@"http://" handler:handler]] resume];
}


@end
