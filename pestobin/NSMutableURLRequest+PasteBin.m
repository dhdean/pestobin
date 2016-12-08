//
//  NSMutableURLRequest+PasteBin.m
//
//  Created by Daniel Dean on 12/6/16.
//

#import "NSMutableURLRequest+PasteBin.h"

@implementation NSMutableURLRequest (PasteBin)


//------------------------------------------------------------------------------
+ (NSMutableURLRequest*)createPastebinPostWithText:(NSString*)text key:(NSString*)key {
    if (!text.length || !key.length) {
        return nil;
    }
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://pastebin.com/api/api_post.php"]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat:@"api_option=paste&api_dev_key=%@&api_paste_code=%@",key, text] dataUsingEncoding:NSUTF8StringEncoding];
    return request;
}


//------------------------------------------------------------------------------
+ (NSMutableURLRequest*)createPastebinOutputWithURLString:(NSString*)urlString {
    if (!urlString.length) {
        return nil;
    }
    NSString* key = [urlString lastPathComponent];
    if (!key.length) {
        return nil;
    }
    NSString* requestLocation = [NSString stringWithFormat:@"http://pastebin.com/raw/%@",key];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestLocation]];
    request.HTTPMethod = @"GET";
    return request;
}

@end
