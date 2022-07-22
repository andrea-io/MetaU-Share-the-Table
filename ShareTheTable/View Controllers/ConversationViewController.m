//
//  ConversationViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/21/22.
//

#import "ConversationViewController.h"

@interface ConversationViewController ()

@end

@implementation ConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.liveQueryClient = [[PFLiveQueryClient alloc] initWithServer:@"wss://livequeryexample.back4app.io" applicationId:@"cfEqijsSr9AS03FR76DJYM374KHH5GddQSQvIU7H" clientKey:@"F9dLUvMhb8D7aMCAukUDMFae630qhhlYTki6dGxP"];

    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"conversationID == %@", self.messageData.conversationID];
    PFQuery<PFObject*>* msgQuery = [PFQuery<PFObject*> queryWithClassName:@"Message" predicate:predicate];
    [msgQuery orderByAscending:@"createdAt"];
    
    [msgQuery findObjectsInBackgroundWithBlock:^(NSArray* messageObjects, NSError *error) {
        if(messageObjects != nil) {
            [self.messages addObjectsFromArray:messageObjects];
            [self.messageTableView reloadData];
        }
    }];
    
    self.subscription = [self.liveQueryClient subscribeToQuery:msgQuery];
    [self.subscription addCreateHandler:^(PFQuery<PFObject *> * _Nonnull query, PFObject * _Nonnull object) {
        if([object isKindOfClass:[Message class]]) {
            [self.messages addObject:object];
        }
    }];
}

- (void)initializeUserData {
    self.messageData.senderID = PFUser.currentUser.objectId;
}

- (void)initializeConversationData {
    [self.messageTableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MessageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    
    self.messageData = self.messages[indexPath.row];
    cell.messageBodyText.text = self.messageData.messageBodyText;
    cell.messageUserName.text = self.messageData.user.username;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
