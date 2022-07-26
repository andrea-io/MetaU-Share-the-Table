//
//  Conversation.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/26/22.
//

#import "Conversation.h"

@implementation Conversation

@dynamic userOneID;
@dynamic userTwoID;
@dynamic convoMessages;

+ (nonnull NSString *)parseClassName {
    return @"Conversation";
}
@end
