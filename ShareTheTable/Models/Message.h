//
//  Message.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/21/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Message : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString* senderID;
@property (nonatomic, strong) NSString* conversationID;
@property (nonatomic, strong) PFUser* user;
@property (nonatomic, strong) NSString* messageBodyText;

+ (void) pushMessage: ( PFUser * _Nullable )user withMessage: ( NSString * _Nullable )messageBodyText withConversation: (NSString * _Nullable)conversationID withSender: (PFObject * _Nullable)senderID withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
