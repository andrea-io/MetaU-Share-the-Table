//
//  ConversationViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/21/22.
//

#import "ConversationViewController.h"
#import "Message.h"
#import "Parse/Parse.h"
#import "ParseLiveQuery/ParseLiveQuery-Swift.h"
@interface ConversationViewController ()

@end

@implementation ConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"conversationID == %@", self.messageData.conversationID];
    PFQuery<PFObject*>* query = [PFQuery<PFObject*> queryWithClassName:@"Message" predicate:predicate];
    [query orderByAscending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray* messageObjects, NSError *error) {
        if(messageObjects != nil) {
            [self.messages addObjectsFromArray:messageObjects];
            [self.messageTableView reloadData];
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
