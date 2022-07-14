//
//  FeedViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/6/22.
//

#import "FeedViewController.h"
#import "Parse/Parse.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

- (IBAction)tapMessage:(id)sender {
    [self performSegueWithIdentifier:@"feedToMessageSegue" sender:nil];
}

- (IBAction)tapViewProfile:(id)sender {
    [self performSegueWithIdentifier:@"feedToSearchSegue" sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser* currentUser = [PFUser currentUser];
    
    NSString* usersName = currentUser[@"firstName"];
    
    self.welcomeLabel.text = [@"Hi, " stringByAppendingString:usersName];
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
