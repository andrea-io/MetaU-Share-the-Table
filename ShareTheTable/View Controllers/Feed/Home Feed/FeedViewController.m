//
//  FeedViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/6/22.
//

#import "FeedViewController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

- (IBAction)tapMessage:(id)sender {
    [self performSegueWithIdentifier:@"feedToMessageSegue" sender:nil];
}

- (IBAction)tapViewProfile:(id)sender {
    [self performSegueWithIdentifier:@"feedToSearchSegue" sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
