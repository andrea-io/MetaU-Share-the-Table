//
//  Conversation.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/26/22.
//

#import "Conversation.h"
#import "UserInfo.h"
#import "Parse/Parse.h"

@implementation Conversation

@dynamic userInfoOnePointer;
@dynamic userInfoTwoPointer;
@dynamic convoMessages;

+ (nonnull NSString *)parseClassName {
    return @"Conversation";
}

- (nonnull NSMutableArray*) fetchConversationMessages: (NSString* _Nullable)conversationID {
    
    Conversation* conversation = [Conversation objectWithoutDataWithClassName:@"Conversation" objectId:conversationID];
    [conversation fetch];
    NSMutableArray* convoMessages = [[NSMutableArray alloc] init];

    [convoMessages addObjectsFromArray:conversation[@"messages"]];
    
    return convoMessages;
}
@end
