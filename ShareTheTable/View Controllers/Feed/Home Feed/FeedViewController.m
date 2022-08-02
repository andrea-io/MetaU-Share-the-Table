//
//  FeedViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/6/22.
//

#import "FeedViewController.h"
#import "BusinessInfo.h"
#import "YelpCell.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>

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
    
    self.yelpTableView.delegate = self;
    self.yelpTableView.dataSource = self;
        
    double lat = 40.78;
    double longt = -73.96;
    
    BusinessInfo* test = [BusinessInfo new];
    
    self.places = [test fetchBusinesses:lat withLongitude:longt withLimit:20];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    YelpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YelpCell" forIndexPath:indexPath];
    
    cell.restaurantName.text = @"Idk";
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.places.count;
}

@end
