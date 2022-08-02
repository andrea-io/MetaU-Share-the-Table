//
//  MessageInboxViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/8/22.
//

#import "MessageInboxViewController.h"
#import "SceneDelegate.h"
#import "FeedViewController.h"
#import "Parse/Parse.h"
#import "ConversationCell.h"
#import "ConversationViewController.h"
#import "Conversation.h"
#import "UserInfo.h"

@interface MessageInboxViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MessageInboxViewController
- (IBAction)tapBack:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FeedViewController *navViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabNav"];
    sceneDelegate.window.rootViewController = navViewController;
}

- (IBAction)tapButton:(id)sender {
    [self performSegueWithIdentifier:@"testSegue" sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.conversationTableView.delegate = self;
    self.conversationTableView.dataSource = self;
    self.conversationTableView.rowHeight = UITableViewAutomaticDimension;
    
    UserInfo* user = [[UserInfo alloc] init];
    self.arrayOfConversations = [[NSMutableArray alloc] init];
    
    PFObject* currentUser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
    [query whereKey:@"userPointer" equalTo:currentUser];
    self.currentUserInfo = [query getFirstObject];
    
    self.arrayOfConversations = [user fetchCurrentConversationList:self.currentUserInfo];

    [self.conversationTableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ConversationCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ConversationCell" forIndexPath:indexPath];
    
    Conversation* convo = self.arrayOfConversations[indexPath.row];
    if([convo.userInfoOnePointer.objectId isEqualToString:self.currentUserInfo.objectId]) {
        UserInfo* user = [UserInfo objectWithoutDataWithObjectId:convo.userInfoTwoPointer.objectId];
        [user fetchIfNeeded];
        cell.conversationUserName.text = user.firstName;
    } else {
        UserInfo* user = [UserInfo objectWithoutDataWithObjectId:convo.userInfoOnePointer.objectId];
        [user fetchIfNeeded];
        cell.conversationUserName.text = user.firstName;
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfConversations.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber* rowNumber = [NSNumber numberWithInt:indexPath.row];

    [self performSegueWithIdentifier:@"inboxToConversationSegue" sender:rowNumber];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"inboxToConversationSegue"]) {
        
        Conversation* conversationSelected = [self.arrayOfConversations objectAtIndex:sender];
        UserInfo* detailUser;
        
        if([conversationSelected.userInfoOnePointer.objectId isEqualToString:self.currentUserInfo.objectId]) {
            detailUser = [UserInfo objectWithoutDataWithObjectId:conversationSelected.userInfoTwoPointer.objectId];
            [detailUser fetchIfNeeded];
        } else {
            detailUser = [UserInfo objectWithoutDataWithObjectId:conversationSelected.userInfoOnePointer.objectId];
            [detailUser fetchIfNeeded];
        }
        
        ConversationViewController* convoVC = [segue destinationViewController];
        [convoVC setOtherUser:detailUser];
    }
}


@end
