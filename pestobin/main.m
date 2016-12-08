//
//  main.m
//  pestobin
//
//  Created by Daniel Dean on 12/6/16.
//

#import <Foundation/Foundation.h>
#import "PastebinAgent.h"
#import "DPasteAgent.h"

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
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        int random = ((long long)[[NSDate date] timeIntervalSince1970])%2;
        if (random == 0) {
            [PastebinAgent paste:lazyEncoded key:PastebinDeveloperKey handler:^(NSString *pasteUrl, NSError *error) {
                if (error) {
                    NSLog(@"\n\n%@\n\n",error);
                } else {
                    NSLog(@"\n\n%@\n\n",pasteUrl);
                }
                [PastebinAgent getOutputForPaste:pasteUrl handler:^(NSString * _Nullable pasteUrl, NSError * _Nullable error) {
                    if (error) {
                        NSLog(@"\n\n%@\n\n",error);
                    } else {
                        NSLog(@"\n\n%@\n\n",pasteUrl);
                    }
                    dispatch_semaphore_signal(sema);
                }];
            }];
        } else {
            [DPasteAgent paste:lazyEncoded handler:^(NSString *pasteUrl, NSError *error) {
                if (error) {
                    NSLog(@"\n\n%@\n\n",error);
                } else {
                    NSLog(@"\n\n%@\n\n",pasteUrl);
                }
                dispatch_semaphore_signal(sema);
            }];
        }
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    return 0;
}
