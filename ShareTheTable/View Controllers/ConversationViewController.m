//
//  ConversationViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/21/22.
//

#import "ConversationViewController.h"

@interface ConversationViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeUserData];
    [self initializeConversationData];
    
    self.messageTableView.dataSource = self;
    self.messageTableView.delegate = self;
    self.messageTableView.rowHeight = UITableViewAutomaticDimension;
    
    // Do any additional setup after loading the view.
    self.liveQueryClient = [[PFLiveQueryClient alloc] initWithServer:@"wss://sharethetable.b4a.io" applicationId:@"IgLS0pEFPPTPM0LeAw7GKes2N0o5gIYmhxMaEyvR" clientKey:@"2YcygA4JtK1E3ymXS1i4EIhOAEFv9PZy5kw5DfDM"];

    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"conversationID == %@", self.messageData.conversationID];
    PFQuery<PFObject*>* msgQuery = [PFQuery<PFObject*> queryWithClassName:@"Message" predicate:predicate];
    [msgQuery orderByAscending:@"createdAt"];
    
    [msgQuery findObjectsInBackgroundWithBlock:^(NSArray* messageObjects, NSError *error) {
        if(error != nil) {
            self.messages = [[NSMutableArray alloc] initWithArray:messageObjects];
            [self.messageTableView reloadData];
        }
    }];
    
    
    self.subscription = [self.liveQueryClient subscribeToQuery:msgQuery];
    __weak typeof(self) weakSelf = self;

    [self.subscription addCreateHandler:^(PFQuery* _Nonnull query, PFObject* _Nonnull object) {
        if([object isKindOfClass:[Message class]]) {
            [weakSelf.messages addObject:object];
            [weakSelf.messageTableView reloadData];
        } else {
            NSLog(@"This object was not found rip");
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

- (IBAction)didTapSendMessage:(id)sender {
    Message* message = [Message new];
    message.messageBodyText = self.textMessageBody.text;
    message.senderID = [PFUser currentUser].objectId;
    message.conversationID = self.convoID;

    [message saveInBackgroundWithBlock:^(BOOL suceeded, NSError* _Nullable error) {
        if(suceeded) {
            NSLog(@"Message was sent");
            [self.messageTableView reloadData];
        }
    }];
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
