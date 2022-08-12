//
//  SearchViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/12/22.
//

#import "SearchViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Parse/Parse.h"
#import "ResultsViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

NSInteger const MIN_AGE = 18;
NSInteger const MAX_AGE = 50;
NSInteger const MIN_DISTANCE = 1;
NSInteger const NUMBER_OF_LINES = 1;
NSInteger const DIET_PREF_SEARCH_TAG = 1;
NSInteger const FOOD_PREF_SEARCH_TAG = 2;
static CGFloat const kViewControllerRangeSliderWidth = 290.0;
static CGFloat const kViewControllerLabelWidth = 100.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViewComponents];
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

    self.criteria = [[NSMutableArray alloc] init];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     if([segue.identifier isEqualToString:@"searchToResultsSegue"]){
         ResultsViewController* controller = [segue destinationViewController];
         controller.minAge = @([self.rangeSlider minimumValue]);
         controller.maxAge = @([self.rangeSlider maximumValue]);
         controller.criteria = self.criteria;
         NSLog(@"%@", controller.criteria);
     }
 }

- (IBAction)didTapFindUsers:(id)sender {
    [self performSegueWithIdentifier:@"searchToResultsSegue" sender:sender];
}

- (IBAction)didTapAButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    // Refresh button selected
    [self refreshButtons:button];

    // Tag = 1, button pressed was a dietary preference
    if([button tag] == DIET_PREF_SEARCH_TAG) {
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

            [self.criteria addObject:dietPreference];
        } else {
            PFQuery* query = [PFQuery queryWithClassName:@"Preference"];
            [query includeKey:@"preferenceName"];
            [query whereKey:@"preferenceName" equalTo:[button currentTitle]];

            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    NSMutableArray* newPreferences = [self.criteria mutableCopy];
                    PFObject* foundObject = [objects objectAtIndex:0];

                    for (PFObject* obj in self.criteria){
                        if ([obj.objectId isEqual:foundObject.objectId]) {
                            [newPreferences removeObject:obj];
                        }
                    }
                    self.criteria = newPreferences;
                } else {
                // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
    // Tag = 2, button pressed was a food preference
    } else if([button tag] == FOOD_PREF_SEARCH_TAG) {
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

            [self.criteria addObject:foodPreference];
        } else {
            PFQuery* query = [PFQuery queryWithClassName:@"Preference"];
            [query includeKey:@"preferenceName"];
            [query whereKey:@"preferenceName" equalTo:[button currentTitle]];

            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    NSMutableArray* newPreferences = [self.criteria mutableCopy];
                    PFObject* foundObject = [objects objectAtIndex:0];

                    for (PFObject* obj in self.criteria){
                        if ([obj.objectId isEqual:foundObject.objectId]) {
                            [newPreferences removeObject:obj];
                        }
                    }
                    self.criteria = newPreferences;
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
        button.layer.cornerRadius = 20;
    } else {
        // Button was not already selected
        button.selected = YES;
        [button setBackgroundColor:UIColor.systemMintColor];
        button.layer.cornerRadius = 20;
    }
}

- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat labelX = (CGRectGetWidth(self.view.frame) - kViewControllerLabelWidth) / 2;
        self.ageRangeLabel.frame = CGRectMake(labelX, 250, 290, 20.0);

        CGFloat sliderX = (CGRectGetWidth(self.view.frame) - kViewControllerRangeSliderWidth) / 2;
        self.rangeSlider.frame = CGRectMake(sliderX, 300, 290.0, 20.0);
}

- (void)rangeSliderValueDidChange:(MARKRangeSlider *)slider {
    [self updateRangeText];
}

- (void)setUpViewComponents {
    // Init label
    self.ageRangeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.ageRangeLabel.backgroundColor = UIColor.systemBackgroundColor;
        self.ageRangeLabel.numberOfLines = NUMBER_OF_LINES;
        self.ageRangeLabel.textColor = UIColor.systemMintColor;
    [self.ageRangeLabel setFont:[UIFont boldSystemFontOfSize:20]];

    // Init slider
    self.rangeSlider = [[MARKRangeSlider alloc] initWithFrame:CGRectZero];
    self.rangeSlider.backgroundColor = UIColor.systemBackgroundColor;
    
    [self.rangeSlider addTarget:self
                         action:@selector(rangeSliderValueDidChange:)
               forControlEvents:UIControlEventValueChanged];

    [self.rangeSlider setMinValue:MIN_AGE maxValue:MAX_AGE];
    [self.rangeSlider setLeftValue:MIN_AGE rightValue:MAX_AGE];

    self.rangeSlider.minimumDistance = MIN_DISTANCE;

    [self updateRangeText];

    [self.view addSubview:self.rangeSlider];
    [self.view addSubview:self.ageRangeLabel];
}

- (void)updateRangeText {
    self.ageRangeLabel.text = [NSString stringWithFormat:@"%0.2f - %0.2f",
                           self.rangeSlider.leftValue, self.rangeSlider.rightValue];
}

@end
