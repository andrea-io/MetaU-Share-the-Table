//
//  ConversationViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/21/22.
//

#import "ConversationViewController.h"
#import "DetailProfileViewController.h"
#import "SceneDelegate.h"
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
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
}

- (void)onTimer {
    [self refreshConversationData];
}

- (void)initializeUserData {
    // Repeated code below, will create a function to fetch UserInfo
    PFObject* currentUser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
    [query whereKey:@"userPointer" equalTo:currentUser];
    self.currentUserInfo = [query getFirstObject];
}

-(void)initializeConversation {
    self.textMessageBody.text = @"";
    UserInfo* user = [[UserInfo alloc] init];
    self.convoID = [user checkIfConversationExists:self.otherUser withCurrentUser:self.currentUserInfo];
    [self refreshConversationData];
}

- (void)refreshConversationData {
    Conversation* convo = [[Conversation alloc] init];
    self.messages = [convo fetchConversationMessages:self.convoID];
    [self.messageTableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    Message* message = self.messages[indexPath.row];
    [message fetch];
    
    PFUser* user = [PFUser objectWithoutDataWithObjectId:message.senderID];
    [user fetch];
    
    // If message is from the current user logged in
    if(PFUser.currentUser.username == user.username) {
        MessageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
        cell.messageBodyText.text = message.messageBodyText;
        cell.messageUserName.text = user.username;
        
        return cell;
    } else {
        ReceiverMessageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiverMessageCell" forIndexPath:indexPath];
        cell.messageBodyText.text = message.messageBodyText;
        cell.messageUserName.text = user.username;
        
        return cell;
    }
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
