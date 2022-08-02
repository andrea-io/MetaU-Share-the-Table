//
//  Conversation.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/26/22.
//

#import <Parse/Parse.h>
@class UserInfo;

NS_ASSUME_NONNULL_BEGIN

@interface Conversation : PFObject<PFSubclassing>

@property (nonatomic, strong) PFObject* userInfoOnePointer;
@property (nonatomic, strong) PFObject* userInfoTwoPointer;
@property (nonatomic, strong) NSMutableArray* convoMessages;

- (nonnull NSMutableArray*) fetchConversationMessages: (NSString* _Nullable)conversationID;

@end

NS_ASSUME_NONNULL_END
