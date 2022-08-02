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

static CGFloat const kViewControllerRangeSliderWidth = 290.0;
static CGFloat const kViewControllerLabelWidth = 100.0;

@interface SearchViewController ()

@end

@implementation SearchViewController

NSInteger const MIN_AGE = 18;
NSInteger const MAX_AGE = 50;
NSInteger const MIN_DISTANCE = 1;
NSInteger const NUMBER_OF_LINES = 1;


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     if([segue.identifier isEqualToString:@"searchToResultsSegue"]){
         ResultsViewController* controller = [segue destinationViewController];
         controller.minAge = @([self.rangeSlider minimumValue]);
         controller.maxAge = @([self.rangeSlider maximumValue]);
     }
 }

- (IBAction)didTapFindUsers:(id)sender {
    [self performSegueWithIdentifier:@"searchToResultsSegue" sender:sender];
}

- (IBAction)didTapDietaryRestrictions:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViewComponents];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat labelX = (CGRectGetWidth(self.view.frame) - kViewControllerLabelWidth) / 2;
    self.ageRangeLabel.frame = CGRectMake(labelX, 110.0, kViewControllerLabelWidth, 20.0);

    CGFloat sliderX = (CGRectGetWidth(self.view.frame) - kViewControllerRangeSliderWidth) / 2;
    self.rangeSlider.frame = CGRectMake(sliderX, labelX + 20.0, 290.0, 20.0);
}

- (void)rangeSliderValueDidChange:(MARKRangeSlider *)slider {
    [self updateRangeText];
}

- (void)setUpViewComponents {
    // Init label
    self.ageRangeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.ageRangeLabel.backgroundColor = UIColor.redColor;
        self.ageRangeLabel.numberOfLines = NUMBER_OF_LINES;
        self.ageRangeLabel.textColor = UIColor.blueColor;
    
    // Init slider
    self.rangeSlider = [[MARKRangeSlider alloc] initWithFrame:CGRectZero];
    self.rangeSlider.backgroundColor = UIColor.greenColor;
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
