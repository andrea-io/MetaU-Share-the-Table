//
//  Conversation.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/26/22.
//

#import <Parse/Parse.h>
#import "UserInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface Conversation : PFObject<PFSubclassing>

@property (nonatomic, strong) PFObject* userOnePoint;
@property (nonatomic, strong) PFObject* userTwoPoint;
@property (nonatomic, strong) NSMutableArray* convoMessages;

- (nonnull NSMutableArray*) fetchCurrentConversationList: (PFObject* _Nullable)currentUser;
- (nonnull NSMutableArray*) fetchConversationMessages: (NSString* _Nullable)conversationID;
- (nonnull NSString* ) checkIfConversationExists: (UserInfo* _Nullable )otherUser withCurrentUser: (UserInfo* _Nullable )currentUser;
- (void) addUserToMatchesList: (PFObject* _Nullable)otherUser withCurrentUser:( PFObject* _Nullable) currentUser withConvo: (Conversation* _Nullable)conversation;
@end

NS_ASSUME_NONNULL_END
