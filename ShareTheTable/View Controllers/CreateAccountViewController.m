//
//  CreateAccountViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/6/22.
//

#import "CreateAccountViewController.h"
#import "Parse/Parse.h"
@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController

- (IBAction)registerUser:(id)sender {
    // Initialize a user object
    PFUser *newUser = [PFUser user];
    
    // Set user properties
    newUser.username = self.usernameTextView.text;
    newUser.password = self.passwordTextView.text;
        
    // Check if the user left either the username and/or password fields empty
    if ([self.usernameTextView.text isEqual:@""] || [self.passwordTextView.text isEqual:@""]) {
        // Create alert controller for empty username and/or password text fields
        UIAlertController *emptyFieldAlert = [UIAlertController alertControllerWithTitle:@"Username and Password Required" message:@"Please enter your username and password" preferredStyle:(UIAlertControllerStyleAlert)];

        // Create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // handle response here.
        }];
        
        // Add the OK action to the alert controller
        [emptyFieldAlert addAction:okAction];
        
        [self presentViewController:emptyFieldAlert animated:YES completion:^{
        }];
    }
    
    // Call sign up function on the user object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            // Manually segue to feed view
            [self performSegueWithIdentifier:@"createAccountToFeedSegue" sender:nil];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
