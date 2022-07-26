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

    // Do any additional setup after loading the view.
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"username != %@", [PFUser currentUser].username];
    PFQuery* query = [PFUser queryWithPredicate:predicate];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray* _Nullable objects, NSError* error) {
        if(error != nil) {
            NSLog(@"Error with retrieving users");
        } else {
            self.arrayOfConversations = [NSArray arrayWithArray:objects];
            [self.conversationTableView reloadData];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ConversationCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ConversationCell" forIndexPath:indexPath];
    PFUser* user = self.arrayOfConversations[indexPath.row];
    
    cell.conversationUserName.text = user.username;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfConversations.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"inboxToConversationSegue" sender:indexPath];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"inboxToConversationSegue"]) {
        
        ConversationViewController* convoVC = [segue destinationViewController];
        //convoVC.otherUser.objectId = self.arrayOfConversations[index];
        //convoVC.convoID = self.conversation.objectId;
    }
}


@end
