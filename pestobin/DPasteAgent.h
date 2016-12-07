//
//  DPasteAgent.h
//
//  Created by Daniel Dean on 12/7/16.
//

#import "PasteAgent.h"

@interface DPasteAgent : PasteAgent

+ (void)paste:(NSString*)text handler:(PasteAgentURLCallback)handler;

@end
