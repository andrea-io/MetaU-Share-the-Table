//
//  QuestionViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/7/22.
//

#import "QuestionViewController.h"
#import "AddPhotosViewController.h"
#import "SceneDelegate.h"
#import "FeedViewController.h"
#import "Parse/Parse.h"
#import "User.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (IBAction)didTapAButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    // Refresh button selected
    [self refreshButtons:button];
    NSLog(@"Button pressed: %@", [sender currentTitle]);
    
    // Tag = 1, button pressed was a dietary preference
    if([button tag] == 1) {
        PFObject* dietPreference = [[PFObject alloc] initWithClassName:@"Preference"];
        // Check if the button was selected or deselected
        if(button.selected == YES) {
            PFQuery* query = [PFQuery queryWithClassName:@"Preference"];
            
            [query includeKey:@"preferenceName"];
            [query whereKey:@"preferenceName" equalTo:[button currentTitle]];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError* error) {
                if(!error) {
                    PFObject* foundObject = [objects objectAtIndex:0];
                    [dietPreference setObjectId:foundObject.objectId];
                } else {
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
            
            [self.allPreferences addObject:dietPreference];
        } else {
            PFQuery* query = [PFQuery queryWithClassName:@"Preference"];
            [query includeKey:@"preferenceName"];
            [query whereKey:@"preferenceName" equalTo:[button currentTitle]];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    NSMutableArray* newPreferences = [self.allPreferences mutableCopy];
                    PFObject* foundObject = [objects objectAtIndex:0];

                    for (PFObject* obj in self.allPreferences){
                        if ([obj.objectId isEqual:foundObject.objectId]) {
                            [newPreferences removeObject:obj];
                        }
                    }
                    self.allPreferences = newPreferences;
                } else {
                // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
    // Tag = 2, button pressed was a food preference
    } else if([button tag] == 2) {
        PFObject* foodPreference = [[PFObject alloc] initWithClassName:@"Preference"];
        // Check if the button was selected or deselected
        if(button.selected == YES) {
            PFQuery* query = [PFQuery queryWithClassName:@"Preference"];
            
            [query includeKey:@"preferenceName"];
            [query whereKey:@"preferenceName" equalTo:[button currentTitle]];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError* error) {
                if(!error) {
                    PFObject* foundObject = [objects objectAtIndex:0];
                    [foodPreference setObjectId:foundObject.objectId];
                } else {
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
            
            [self.allPreferences addObject:foodPreference];
        } else {
            PFQuery* query = [PFQuery queryWithClassName:@"Preference"];
            [query includeKey:@"preferenceName"];
            [query whereKey:@"preferenceName" equalTo:[button currentTitle]];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    NSMutableArray* newPreferences = [self.allPreferences mutableCopy];
                    PFObject* foundObject = [objects objectAtIndex:0];

                    for (PFObject* obj in self.allPreferences){
                        if ([obj.objectId isEqual:foundObject.objectId]) {
                            [newPreferences removeObject:obj];
                        }
                    }
                    self.allPreferences = newPreferences;
                } else {
                // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
    }
}

- (void)refreshButtons:(UIButton*)button {
    // Button was already selected
    if(button.selected == YES) {
        button.selected = NO;
        [button setBackgroundColor:UIColor.clearColor];
    } else {
        // Button was not already selected
        button.selected = YES;
        [button setBackgroundColor:UIColor.greenColor];
    }
}

- (IBAction)tapCompleteProfile:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FeedViewController *navViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabNav"];
    sceneDelegate.window.rootViewController = navViewController;
    
    PFObject* currentUser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
    [query whereKey:@"userPointer" equalTo:currentUser];
    UserInfo *userInfo = [query getFirstObject];
    for(PFObject* obj in self.allPreferences) {
        [userInfo addObject:obj forKey:@"allPreferences"];
        [userInfo saveInBackground];
    }
    
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"Error pushing user: %@", error.localizedDescription);
        }
        else{
            [self.delegate didPush:userInfo];
            NSLog(@"Pushed user, Success!");
        }
    }];
    
//    [User pushUserToFeed:[PFUser currentUser] withName:currentUser[@"firstName"] withAge:currentUser[@"ageValue"] withLocation:currentUser[@"locationName"] withCompletion:^(BOOL succeeded, NSError* _Nullable error) {
//
//    }];
}

- (IBAction)tapBack:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AddPhotosViewController *navViewController = [storyboard instantiateViewControllerWithIdentifier:@"Nav"];
    sceneDelegate.window.rootViewController = navViewController;
    
    // TODO: DELETE ACCOUNT MADE
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.veganButton.selected = NO;
    self.vegitarianButton.selected = NO;
    self.kosherButton.selected = NO;
    self.glutenFreeButton.selected = NO;
    self.lactoseIntolerantButton.selected = NO;
    self.seaFoodAllergiesButton.selected = NO;
    self.chineseFoodButton.selected = NO;
    self.mexicanFoodButton.selected = NO;
    self.americanFoodButton.selected = NO;
    self.italianFoodButton.selected = NO;
    self.greekFoodButton.selected = NO;
    self.otherFoodButton.selected = NO;
    
    self.allPreferences = [[NSMutableArray alloc] init];
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
