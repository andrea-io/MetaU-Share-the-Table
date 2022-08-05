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
NSInteger const CUISINE_TYPE_TAG = 2;
NSInteger const DIETARY_RESTRICTION_TYPE_TAG = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray* preferences = self.detailUser[@"allPreferences"];
    for(PFObject* pref in preferences) {
        [pref fetch];
        if(pref[@"typeID"] == CUISINE_TYPE_TAG) {
            [self.detailLocationLabel.text stringByAppendingString:pref[@"preferenceName"]];
        } else {
            [self.detailLocationLabel.text stringByAppendingString:pref[@"preferenceName"]];
        }
    }
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
        UINavigationController *navigationController = segue.destinationViewController;
                ConversationViewController* convoVC = (ConversationViewController*) navigationController.topViewController;
        [convoVC setOtherUser:otherUser];
    }
}


@end
