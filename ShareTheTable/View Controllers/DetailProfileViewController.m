//
//  DetailProfileViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/20/22.
//

#import "DetailProfileViewController.h"
#import "ConversationViewController.h"
#import "Conversation.h"

@interface DetailProfileViewController ()

@end

@implementation DetailProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set up all text labels
    self.detailUserFirstNameLabel.text = self.detailUser.firstName;
    self.detailUserAgeLabel.text = [self.detailUser.ageValue stringValue];
    self.detailLocationLabel.text = self.detailUser.location;
}

- (IBAction)didTapMessageUser:(id)sender {

//    // Create new conversation object
//    self.conversation = [PFObject objectWithClassName:@"Conversation"];
//    // Assign the users that will be communicating
//    PFObject* currentUser = [PFUser currentUser];
//    PFUser* idk = self.detailUser.user;
//    PFObject* otherUser = idk;
//
//    [self.conversation setObject:currentUser forKey:@"userOnePointer"];
//    [self.conversation setObject:otherUser forKey:@"userTwoPointer"];
    
    // Segue to the conversation VC and display messages
//    [self.conversation saveInBackgroundWithBlock:^(BOOL succeeded, NSError* _Nullable error) {
//        if(succeeded) {
//            NSLog(@"Conversation object was saved");
//            NSLog(@"%@", self.conversation.objectId);
//        } else {
//            NSLog(@"%@", error);
//        }
//    }];
    [self performSegueWithIdentifier:@"profileToMessageSegue" sender:self.detailUser];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"profileToMessageSegue"]) {
        PFUser* otherUser = sender;
        
        ConversationViewController* convoVC = [segue destinationViewController];
        [convoVC setOtherUser:otherUser];
    }
}


@end
