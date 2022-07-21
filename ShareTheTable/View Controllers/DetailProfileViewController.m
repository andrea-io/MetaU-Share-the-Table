//
//  DetailProfileViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/20/22.
//

#import "DetailProfileViewController.h"

@interface DetailProfileViewController ()

@end

@implementation DetailProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set up all text labels
    self.detailUserFirstNameLabel.text = self.detailUser.firstName;
    self.detailUserAgeLabel.text = [self.detailUser.ageValue stringValue];
    self.detailLocationLabel.text = self.detailUser.location;
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
