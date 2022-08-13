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
#import "FeedViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    
    [self.textMessageBody.layer setCornerRadius:10.0f];
    
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
    if([PFUser.currentUser.username isEqualToString:user.username]) {
        SenderMessageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SenderMessageCell" forIndexPath:indexPath];
        cell.messageBodyText.text = message.messageBodyText;
        cell.messageUserName.text = user.username;
        
        [cell.messageBodyText.layer setMasksToBounds:true];
        cell.messageBodyText.layer.cornerRadius = 3;
        
        NSData* imageData = [[NSData alloc] initWithBase64Encoding:[self.currentUserInfo.userPhotos objectAtIndex:0]];
        
        UIImage* image = [UIImage imageWithData:imageData];
        
        cell.senderMessageUserImage.layer.cornerRadius = 10.0;
        cell.senderMessageUserImage.clipsToBounds = YES;
        cell.senderMessageUserImage.image = image;
        
        return cell;
    } else {
        ReceiverMessageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiverMessageCell" forIndexPath:indexPath];
        cell.messageBodyText.text = message.messageBodyText;
        cell.messageUserName.text = user.username;
        
        [cell.messageBodyText.layer setMasksToBounds:true];
        cell.messageBodyText.layer.cornerRadius = 3;

        NSData* imageData = [[NSData alloc] initWithBase64Encoding:[self.otherUser.userPhotos objectAtIndex:0]];
        
        UIImage* image = [UIImage imageWithData:imageData];
        
        cell.receiverMessageUserImage.layer.cornerRadius = 10.0;
        cell.receiverMessageUserImage.clipsToBounds = YES;
        cell.receiverMessageUserImage.image = image;
        
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

- (IBAction)didTapBack:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FeedViewController *feedViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabNav"];
    sceneDelegate.window.rootViewController = feedViewController;
}

@end
