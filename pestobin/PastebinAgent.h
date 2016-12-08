//
//  PasteBinAgent.h
//
//  Created by Daniel Dean on 12/6/16.
//

#import "PasteAgent.h"

@interface PastebinAgent : PasteAgent

- (id)initWithAPIKey:(NSString*)key;

- (void)paste:(NSString*)text handler:(PasteAgentURLCallback)handler;

+ (void)paste:(NSString*)text key:(NSString*)key handler:(PasteAgentURLCallback)handler;

+ (void)getOutputForPaste:(NSString*)urlString handler:(PasteAgentURLCallback)handler;

@end
