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

@interface QuestionViewController ()

@end

@implementation QuestionViewController

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

- (IBAction)didTapSeaFoodAllergies:(id)sender {
    [self refreshButtons:self.seaFoodAllergiesButton];
}

- (IBAction)didTapLactoseIntolerant:(id)sender {
    [self refreshButtons:self.lactoseIntolerantButton];
}

- (IBAction)didTapGlutenFree:(id)sender {
    [self refreshButtons:self.glutenFreeButton];
}

- (IBAction)didTapKosher:(id)sender {
    [self refreshButtons:self.kosherButton];
}

- (IBAction)didTapVegetarian:(id)sender {
    [self refreshButtons:self.vegitarianButton];
}

- (IBAction)didTapVegan:(id)sender {
    [self refreshButtons:self.veganButton];
}

- (IBAction)tapCompleteProfile:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FeedViewController *navViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabNav"];
    sceneDelegate.window.rootViewController = navViewController;
    
    PFObject* currentUser = [PFUser currentUser];
    
    if(self.veganButton.selected == YES) {
        [currentUser addObject:@"Vegan" forKey:@"dietaryRestrictions"];
        [currentUser saveInBackground];
    }
    
    if(self.vegitarianButton.selected == YES) {
        [currentUser addObject:@"Vegetarian" forKey:@"dietaryRestrictions"];
        [currentUser saveInBackground];
    }
    
    if(self.kosherButton.selected == YES) {
        [currentUser addObject:@"Kosher" forKey:@"dietaryRestrictions"];
        [currentUser saveInBackground];
    }
    
    if(self.glutenFreeButton.selected == YES) {
        [currentUser addObject:@"Gluten Free" forKey:@"dietaryRestrictions"];
        [currentUser saveInBackground];
    }
    
    if(self.lactoseIntolerantButton.selected == YES) {
        [currentUser addObject:@"Lactose Intolerant" forKey:@"dietaryRestrictions"];
        [currentUser saveInBackground];
    }
    
    if(self.seaFoodAllergiesButton.selected == YES) {
        [currentUser addObject:@"Seafood Allergies" forKey:@"dietaryRestrictions"];
        [currentUser saveInBackground];
    }
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
