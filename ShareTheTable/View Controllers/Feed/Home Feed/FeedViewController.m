//
//  FeedViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/6/22.
//

#import "FeedViewController.h"
#import "AppDelegate.h"
#import <YelpAPI/YLPClient+Search.h>
#import <YelpAPI/YLPSortType.h>
#import <YelpAPI/YLPSearch.h>
#import <YelpAPI/YLPBusiness.h>
#import "YelpCell.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "InitialViewController.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@end

@implementation FeedViewController

NSInteger const TOP_NUM_RESULTS = 20;
NSInteger const NUMBER_OF_TAPS = 2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.yelpTableView.delegate = self;
    self.yelpTableView.dataSource = self;
    
    PFObject* currentUser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
    [query whereKey:@"userPointer" equalTo:currentUser];
    self.currentUserInfo = [query getFirstObject];
    
    self.welcomeLabel.text = [@"Hi, " stringByAppendingString:self.currentUserInfo.firstName];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager requestWhenInUseAuthorization];
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.locationManager.pausesLocationUpdatesAutomatically = false;
    self.locationManager.allowsBackgroundLocationUpdates = true;
    
    [self.locationManager startUpdatingLocation];
    CLLocation* location = self.locationManager.location;
    
    double lat = location.coordinate.latitude;
    double longt = location.coordinate.longitude;
    
    YLPCoordinate* coord = [[YLPCoordinate alloc] initWithLatitude:lat longitude:longt];
    
    [[AppDelegate sharedClient] searchWithCoordinate:coord term:nil limit:TOP_NUM_RESULTS offset:0 sort:YLPSortTypeDistance completionHandler:^(YLPSearch * _Nullable search, NSError * _Nullable error) {
        self.search = search;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.yelpTableView reloadData];
        });
    }];
}

- (IBAction)tapViewProfile:(id)sender {
    [self performSegueWithIdentifier:@"feedToSearchSegue" sender:nil];
}

- (IBAction)tapLogoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InitialViewController *initialViewController = [storyboard instantiateViewControllerWithIdentifier:@"NavController"];
    sceneDelegate.window.rootViewController = initialViewController;
}

- (IBAction)didDoubleTap:(UITapGestureRecognizer*)gesture {
    UIView* gestureView = gesture.view;
    UIImageView* heart = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"heart.fill"]];
    
    [heart setFrame:CGRectMake(0, 0, gestureView.frame.size.width / 4, gestureView.frame.size.height / 4)];
    [heart setTintColor:UIColor.whiteColor];
    [heart setCenter:gestureView.center];
    
    NSIndexPath* index = [NSIndexPath indexPathForRow:gestureView.tag inSection:0];
    
    YelpCell* cell = [self.yelpTableView cellForRowAtIndexPath:index];
    
    [cell.contentView addSubview:heart];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Code to be executed on the main queue after delay
        [UIView animateWithDuration:0.5 animations:^{
            [heart setAlpha:0];
        } completion:^(BOOL finished) {
            [heart removeFromSuperview];
            [self.currentUserInfo addObject:self.search.businesses[index.item].identifier forKey:@"favoriteYelpResults"];
            [self.currentUserInfo save];
        }];
    });
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    YelpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YelpCell" forIndexPath:indexPath];
    
    cell.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
    cell.tapGesture.view.tag = indexPath.row;
    cell.tapGesture.numberOfTapsRequired = NUMBER_OF_TAPS;
    [cell setUserInteractionEnabled:YES];
    [cell addGestureRecognizer:cell.tapGesture];
    
    if (indexPath.item > [self.search.businesses count]) {
        cell.restaurantName.text = @"";
        cell.restaurantLocation.text = @"";
    } else {
        cell.restaurantName.text = self.search.businesses[indexPath.item].name;
            
        if(self.search.businesses[indexPath.item].location.address.count == 0) {
            cell.restaurantLocation.text = @"Location Unavailable";
        } else {
            cell.restaurantLocation.text = self.search.businesses[indexPath.item].location.address[0];
        }
            
        NSData* restaurantImageData = [NSData dataWithContentsOfURL:self.search.businesses[indexPath.item].imageURL];
          
        UIImage* restaurantImage = [UIImage imageWithData:restaurantImageData];
            
        cell.restaurantImageView.image = restaurantImage;
    }
        
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return TOP_NUM_RESULTS;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
