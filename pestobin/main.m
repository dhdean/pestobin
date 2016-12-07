//
//  main.m
//  pestobin
//
//  Created by Daniel Dean on 12/6/16.
//

#import <Foundation/Foundation.h>
#import "PastebinAgent.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

static NSString* const PastebinDeveloperKey = @""; // <------------- Fill in your developer API Key here.

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc < 2) {
            NSLog(@"\n\nUsage: pestobin \"PASTE ME\"\n\n");
            return 1;
        }
        NSString* str = [[NSString alloc] initWithCString:argv[1] encoding:NSUTF8StringEncoding];
        NSString* lazyEncoded = [str stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        
        PastebinAgent* agent = [[PastebinAgent alloc] initWithAPIKey:PastebinDeveloperKey];
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        __block BOOL apiSuccess = false;
        [agent paste:lazyEncoded handler:^(NSString *pasteUrl, NSError *error) {
            if (error) {
                NSLog(@"\n\n%@\n\n",error);
            } else {
                apiSuccess = true;
                NSLog(@"\n\n%@\n\n",pasteUrl);
            }
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    return 0;
}
