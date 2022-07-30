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
    // Do any additional setup after loading the view.
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

- (void)rangeSliderValueDidChange:(MARKRangeSlider *)slider
{
    [self updateRangeText];
}

#pragma mark - UI

- (void)setUpViewComponents
{
    
    // Init label
    self.ageRangeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.ageRangeLabel.backgroundColor = UIColor.redColor;
        self.ageRangeLabel.numberOfLines = 1;
        self.ageRangeLabel.textColor = UIColor.blueColor;
    // Init slider
    self.rangeSlider = [[MARKRangeSlider alloc] initWithFrame:CGRectZero];
    self.rangeSlider.backgroundColor = UIColor.greenColor;
    [self.rangeSlider addTarget:self
                         action:@selector(rangeSliderValueDidChange:)
               forControlEvents:UIControlEventValueChanged];
    //self.rangeSlider.sendInstantUpdates = YES;
    [self.rangeSlider setMinValue:18 maxValue:50];
    [self.rangeSlider setLeftValue:18 rightValue:50];

    self.rangeSlider.minimumDistance = 1;

    [self updateRangeText];

    [self.view addSubview:self.rangeSlider];
    [self.view addSubview:self.ageRangeLabel];
}

- (void)updateRangeText
{
    NSLog(@"%0.2f - %0.2f", self.rangeSlider.leftValue, self.rangeSlider.rightValue);
    self.ageRangeLabel.text = [NSString stringWithFormat:@"%0.2f - %0.2f",
                           self.rangeSlider.leftValue, self.rangeSlider.rightValue];
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
