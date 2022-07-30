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
    
    // Set up all text labels
    self.detailUserFirstNameLabel.text = self.detailUser.firstName;
    self.detailUserAgeLabel.text = [self.detailUser.ageValue stringValue];
    self.detailLocationLabel.text = self.detailUser.locationName;
}

- (IBAction)didTapMessageUser:(id)sender {
    [self performSegueWithIdentifier:@"profileToMessageSegue" sender:self.detailUser];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"profileToMessageSegue"]) {
        UserInfo* otherUser = sender;
        
        ConversationViewController* convoVC = [segue destinationViewController];
        [convoVC setOtherUser:otherUser];
    }
}


@end
