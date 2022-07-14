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

- (void)didPush:(nonnull User *)user {
    //[self.arrayOfPosts insertObject:post atIndex:0];
    [self.userTableView reloadData];
}

- (void) loadMoreData {
    // Construct query
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    //NSNumber *count = [NSNumber numberWithInteger:loadCount];
    
    query.limit = 50;
    
    // Instruct Parse to fetch the related user when we query for messages
    [query includeKey:@"foodPreferences"];

    NSArray *preferences = [[NSArray alloc] initWithObjects:@"Italian", nil];
    for(NSString* string in preferences) {
        NSLog(@"%@", string);
    }

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
    
    User *user = self.arrayOfUsers[indexPath.row];
    
    NSMutableArray* photos = [[NSMutableArray alloc] initWithArray:user[@"userPhotos"]];
    
    NSString* imageString = [photos objectAtIndex:0];
    
    NSData* data = [NSData dataFromBase64String:imageString];
    UIImage* recoverImage = [UIImage imageWithData:data];

    cell.userFirstNameLabel.text = user.firstName;
    cell.userAgeLabel.text = user.ageValue;
    cell.userMainPhotoImageView.image = recoverImage;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfUsers.count;
}

- (void)refreshData {
    // Construct query
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query includeKey:@"foodPreferences"];

    
    NSArray *preferences = [[NSArray alloc] initWithObjects:@"Italian", nil];
    for(NSString* string in preferences) {
        NSLog(@"%@", string);
    }
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
