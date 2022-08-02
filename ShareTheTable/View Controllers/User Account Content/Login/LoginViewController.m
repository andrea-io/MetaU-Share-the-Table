//
//  LoginViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/6/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)loginUser:(id)sender {
    // Retrieve user-entered username and password from text fields
    NSString* username = self.usernameTextView.text;
    NSString* password = self.passwordTextView.text;
    
    // Check if the user left either the username and/or password fields empty
    if ([username isEqual:@""] || [password isEqual:@""]) {
        // Create alert controller for empty username and/or password text fields
        UIAlertController *emptyFieldAlert = [UIAlertController alertControllerWithTitle:@"Username and Password Required" message:@"Please enter your username and password" preferredStyle:(UIAlertControllerStyleAlert)];

        // Create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        // Add the OK action to the alert controller
        [emptyFieldAlert addAction:okAction];
        
        [self presentViewController:emptyFieldAlert animated:YES completion:^{
        }];
    }
        
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            // Display feed view controller after successful login
            [self performSegueWithIdentifier:@"loginToFeedSegue" sender:nil];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
