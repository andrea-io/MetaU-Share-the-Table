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
    // Do any additional setup after loading the view.
    
    self.userTableView.dataSource = self;
    self.userTableView.delegate = self;
    self.userTableView.rowHeight = UITableViewAutomaticDimension;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.userTableView insertSubview:refreshControl atIndex:0];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self refreshData];

    // Reload the tableView now that there is new data
    [self.userTableView reloadData];

    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing];
}

- (void)didPush:(nonnull UserInfo *)user {
    //[self.arrayOfPosts insertObject:post atIndex:0];
    [self.userTableView reloadData];
}

- (void) loadMoreData {
    // Construct query
    PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
    [query whereKey:@"ageValue" greaterThan:self.minAge];
    [query whereKey:@"ageValue" lessThan:self.maxAge];
    
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


#pragma mark - Navigation

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    
    UserInfo *user = self.arrayOfUsers[indexPath.row];
    
    cell.userFirstNameLabel.text = user.firstName;
    cell.userAgeLabel.text = [user.ageValue stringValue];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfUsers.count;
}

- (void)refreshData {
    // Construct query
    PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
    [query whereKey:@"ageValue" greaterThan:self.minAge];
    [query whereKey:@"ageValue" lessThan:self.maxAge];
    [query includeKey:@"ageValue"];
    [query includeKey:@"firstName"];
    [query includeKey:@"allPreferences"];
    
    NSString *preferenceURL = [NSString stringWithFormat:@"https://parseapi.back4app.com/users/myCurrentUserId"];
    NSData *preferenceData = [NSData dataWithContentsOfURL:[NSURL URLWithString:preferenceURL]];
  
    NSMutableArray* prefArray = [[NSMutableArray alloc] init];
    prefArray = [NSJSONSerialization JSONObjectWithData:preferenceData options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"%@",prefArray);


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


#pragma mark - Navigation

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
