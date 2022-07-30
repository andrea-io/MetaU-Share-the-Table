//
//  ConversationViewController.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/21/22.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "MessageCell.h"
#import "Parse/Parse.h"
#import "ParseLiveQuery/ParseLiveQuery-Swift.h"
#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConversationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView* textMessageBody;
@property (weak, nonatomic) IBOutlet UITableView* messageTableView;
@property (strong, nonatomic) NSMutableArray* messages;
@property (strong, nonatomic) UserInfo* otherUser;
@property (strong, nonatomic) NSString* convoID;
@property (nonatomic, strong) PFLiveQueryClient* liveQueryClient;
@property (nonatomic, strong) PFQuery* msgQuery;
@property (nonatomic, strong) PFLiveQuerySubscription* subscription;


@end

NS_ASSUME_NONNULL_END
