//
//  ResultsViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/12/22.
//

#import "ResultsViewController.h"
#import "Parse/Parse.h"
#import "UserCell.h"
#import "User.h"
#import "NSData+Base64.h"
#import "SearchViewController.h"
#import "DetailProfileViewController.h"

@interface ResultsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userTableView.dataSource = self;
    self.userTableView.delegate = self;
    self.userTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self loadMoreData];
    [self.userTableView reloadData];
}

- (void) loadMoreData {
    // Construct query
    PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
    [query whereKey:@"ageValue" greaterThan:self.minAge];
    [query whereKey:@"ageValue" lessThan:self.maxAge];
    
    if(self.criteria.count > 0) {
        [query whereKey:@"allPreferences" containsAllObjectsInArray:self.criteria];
    }
    
    [query includeKey:@"ageValue"];
    [query includeKey:@"firstName"];

    // Fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (users != nil) {
            self.arrayOfUsers = [[NSMutableArray alloc] init];
            [self.arrayOfUsers addObjectsFromArray:users];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        // Reload the tableView now that there is new data
        [self.userTableView reloadData];
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    
    UserInfo* user = self.arrayOfUsers[indexPath.row];
    NSString* imageString = [user.userPhotos objectAtIndex:0];
    
    NSData* imageData = [[NSData alloc] initWithBase64Encoding:imageString];
    
    UIImage* image = [UIImage imageWithData:imageData];
    
    cell.userMainPhotoImageView.image = image;
    cell.userFirstNameLabel.text = user.firstName;
    cell.userAgeLabel.text = [user.ageValue stringValue];
    cell.userLocationLabel.text = user.locationName;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfUsers.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"resultsToDetailSegue"]) {
        UserInfo* cell = sender;
        NSIndexPath *myIndexPath = [self.userTableView indexPathForCell:cell];
        
        UserInfo* dataToPass = self.arrayOfUsers[myIndexPath.row];
        DetailProfileViewController *detailVC = [segue destinationViewController];
        detailVC.detailUser = dataToPass;
    }
}


@end
