//
//  ConversationViewController.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/21/22.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "MessageCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConversationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@property (strong, nonatomic) Message* messageData;
@property (strong, nonatomic) NSMutableArray<Message*>* messages;

@end

NS_ASSUME_NONNULL_END
