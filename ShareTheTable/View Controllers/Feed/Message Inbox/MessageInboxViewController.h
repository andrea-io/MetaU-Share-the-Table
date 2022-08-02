//
//  MessageInboxViewController.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageInboxViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *conversationTableView;

@property (strong, nonatomic) NSMutableArray* arrayOfConversations;
@property (strong, nonatomic) UserInfo* currentUserInfo;

@end

NS_ASSUME_NONNULL_END
