//
//  NSMutableURLRequest+DPaste.m
//
//  Created by Daniel Dean on 12/7/16.
//

#import "NSMutableURLRequest+DPaste.h"

@implementation NSMutableURLRequest (DPaste)


//------------------------------------------------------------------------------
+ (NSMutableURLRequest*)createDPastePostWithText:(NSString*)text {
    if (!text.length) {
        return nil;
    }
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://dpaste.com/api/v2/"]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat:@"content=%@", text] dataUsingEncoding:NSUTF8StringEncoding];
    return request;
}


@end
