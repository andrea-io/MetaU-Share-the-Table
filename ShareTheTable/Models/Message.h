//
//  Message.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/21/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Message : PFObject

@property (nonatomic, strong) PFObject* senderID;
@property (nonatomic, strong) PFObject* conversationID;
@property (nonatomic, strong) PFUser* user;
@property (nonatomic, strong) NSString* messageBodyText;

+ (void) pushMessage: ( PFUser * _Nullable )user withMessage: ( NSString * _Nullable )messageBodyText withConversation: (PFObject * _Nullable)conversationID withSender: (PFObject * _Nullable)senderID withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
