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
    
    [self initializeUserData];
    [self initializeConversation];
    
    self.messageTableView.dataSource = self;
    self.messageTableView.delegate = self;
    self.messageTableView.rowHeight = UITableViewAutomaticDimension;
    
    //[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
}

- (void)onTimer {
    [self refreshConversationData];
}

- (void)initializeUserData {
    NSLog(@"Other user: %@", self.otherUser);
    PFObject* currentUser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
    [query whereKey:@"userPointer" equalTo:currentUser];
    self.currentUserInfo = [query getFirstObject];
}

-(void)initializeConversation {
    self.textMessageBody.text = @"";
    Conversation* convo = [[Conversation alloc] init];
    self.convoID = [convo checkIfConversationExists:self.otherUser withCurrentUser:self.currentUserInfo];
    [self refreshConversationData];
}

- (void)refreshConversationData {
    Conversation* convo = [[Conversation alloc] init];
    self.messages = [convo fetchConversationMessages:self.convoID];
    [self.messageTableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MessageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    
    Message* message = self.messages[indexPath.row];
    [message fetch];
    
    cell.messageBodyText.text = message.messageBodyText;
    cell.messageUserName.text = message.senderID;
    
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
