//
//  NSMutableURLRequest+PasteBin.h
//
//  Created by Daniel Dean on 12/6/16.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (PasteBin)

+ (NSMutableURLRequest*)createPastebinPostWithText:(NSString*)text key:(NSString*)key;

@end
