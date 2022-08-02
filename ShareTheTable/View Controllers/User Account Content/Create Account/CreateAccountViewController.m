//
//  CreateAccountViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/6/22.
//

#import "CreateAccountViewController.h"
#import "Parse/Parse.h"
#import "UserInfo.h"

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController

- (IBAction)registerUser:(id)sender {
    // Initialize a user object
    
    PFUser* newUser = [PFUser new];
    
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    
    // Check if the user left either the username and/or password fields empty
    if ([self.usernameTextField.text isEqual:@""] || [self.passwordTextField.text isEqual:@""]) {
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
            UserInfo *userInfo = [UserInfo new];
            userInfo[@"firstName"] = self.firstNameTextField.text;
            userInfo[@"ageValue"] = [NSNumber numberWithInteger:[self.ageTextField.text integerValue]];
            userInfo[@"locationName"] = self.locationTextField.text;
            userInfo[@"userPointer"] = newUser;
            userInfo[@"username"] = newUser[@"username"];
            [userInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error != nil) {
                    NSLog(@"Error: %@", error.localizedDescription);
                } else {
                    // Manually segue to feed view
                    [self performSegueWithIdentifier:@"accountToPhotoSegue" sender:nil];
                }
            }];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
