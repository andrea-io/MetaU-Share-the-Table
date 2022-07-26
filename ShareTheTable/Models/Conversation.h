//
//  Conversation.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/26/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Conversation : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString* userOneID;
@property (nonatomic, strong) NSString* userTwoID;
@property (nonatomic, strong) NSMutableArray* convoMessages;

@end

NS_ASSUME_NONNULL_END
