//
//  NSMutableURLRequest+DPaste.h
//
//  Created by Daniel Dean on 12/7/16.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (DPaste)

+ (NSMutableURLRequest*)createDPastePostWithText:(NSString*)text;

@end
