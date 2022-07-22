//
//  Message.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/21/22.
//

#import "Message.h"

@implementation Message

@dynamic senderID;
@dynamic user;
@dynamic conversationID;
@dynamic messageBodyText;

+ (nonnull NSString *)parseClassName {
    return @"Message";
}

+ (void) pushMessage: ( PFUser * _Nullable )user withMessage: ( NSString * _Nullable )messageBodyText withConversation: (PFObject * _Nullable)conversationID withSender: (PFObject * _Nullable)senderID withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Message *newMessage = [Message new];
    newMessage.user = [PFUser currentUser];
    newMessage.senderID = user.objectId;
    newMessage.messageBodyText = messageBodyText;
    newMessage.conversationID = conversationID;
    
    [newMessage saveInBackgroundWithBlock: completion];
}

@end
