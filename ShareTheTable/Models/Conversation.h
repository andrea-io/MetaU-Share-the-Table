//
//  Conversation.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/26/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Conversation : PFObject<PFSubclassing>

@property (nonatomic, strong) PFObject* userOnePointer;
@property (nonatomic, strong) PFObject* userTwoPointer;
@property (nonatomic, strong) NSMutableArray* convoMessages;

- (nonnull NSMutableArray*) fetchCurrentConversationList: (PFObject* _Nullable)currentUser;
- (nonnull NSMutableArray*) fetchConversationMessages: (NSString* _Nullable)conversationID;
- (nonnull NSString* ) checkIfConversationExists: (PFUser* _Nullable )otherUser withCurrentUser: (PFUser* _Nullable )currentUser;

@end

NS_ASSUME_NONNULL_END
