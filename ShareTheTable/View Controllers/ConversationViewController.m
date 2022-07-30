//
//  ConversationViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/21/22.
//

#import "ConversationViewController.h"
#import "Conversation.h"
#import "UserInfo.h"

@interface ConversationViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.messageTableView.dataSource = self;
    self.messageTableView.delegate = self;
    self.messageTableView.rowHeight = UITableViewAutomaticDimension;
    
    [NSTimer scheduledTimerWithTimeInterval:10000 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    
}

- (void)onTimer {
   // Add code to be run periodically
    [self refreshConversationData];
}

- (void)refreshConversationData {
    Conversation* convo = [[Conversation alloc] init];
    NSLog(@"Other user: %@", self.otherUser);
    PFObject* currentUser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
    [query whereKey:@"userPointer" equalTo:currentUser];
    UserInfo *userInfo = [query getFirstObject];
    
    self.convoID = [convo checkIfConversationExists:self.otherUser withCurrentUser:userInfo];
    
    self.messages = [convo fetchConversationMessages:self.convoID];
    
    [self.messageTableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MessageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    
    Message* message = self.messages[indexPath.row];
    
    cell.messageBodyText.text = message.messageBodyText;
    cell.messageUserName.text = message.user.username;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (IBAction)didTapSendMessage:(id)sender {
    Message* message = [Message new];
    message.messageBodyText = self.textMessageBody.text;
    message.senderID = [PFUser currentUser].objectId;
    message.conversationID = self.convoID;
    [message save];
    self.textMessageBody.text = @"";
    Conversation* convo = [Conversation objectWithoutDataWithObjectId:self.convoID];
    [convo addObject:message forKey:@"messages"];
    [convo save];
    [self.messageTableView reloadData];
    
    [self refreshConversationData];
}

@end
