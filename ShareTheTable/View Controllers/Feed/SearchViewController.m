//
//  SearchViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/12/22.
//

#import "SearchViewController.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat const kViewControllerRangeSliderWidth = 290.0;
static CGFloat const kViewControllerLabelWidth = 100.0;

@interface SearchViewController ()

@end

@implementation SearchViewController
- (IBAction)didTapFindUsers:(id)sender {
    [self.criteria addObject:@"Vegan"];
    [self performSegueWithIdentifier:@"searchToResultsSegue" sender:nil];
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
    //self.label.frame = CGRectMake(labelX, 110.0, kViewControllerLabelWidth, 20.0);

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
    // Init slider
    self.rangeSlider = [[MARKRangeSlider alloc] initWithFrame:CGRectZero];
    self.rangeSlider.backgroundColor = UIColor.greenColor;
    [self.rangeSlider addTarget:self
                         action:@selector(rangeSliderValueDidChange:)
               forControlEvents:UIControlEventValueChanged];
    //self.rangeSlider.sendInstantUpdates = YES;
    [self.rangeSlider setMinValue:0.0 maxValue:1.0];
    [self.rangeSlider setLeftValue:0.2 rightValue:0.7];

    self.rangeSlider.minimumDistance = 0.2;

    [self updateRangeText];

    [self.view addSubview:self.rangeSlider];
}

- (void)updateRangeText
{
    NSLog(@"%0.2f - %0.2f", self.rangeSlider.leftValue, self.rangeSlider.rightValue);
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
