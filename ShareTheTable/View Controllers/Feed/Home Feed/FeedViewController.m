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

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@end

@implementation FeedViewController

NSInteger const TOP_NUM_RESULTS = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.yelpTableView.delegate = self;
    self.yelpTableView.dataSource = self;
    self.welcomeLabel.text = [@"Hi, " stringByAppendingString:PFUser.currentUser.username];
    
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

- (IBAction)tapMessage:(id)sender {
    [self performSegueWithIdentifier:@"feedToMessageSegue" sender:nil];
}

- (IBAction)tapViewProfile:(id)sender {
    [self performSegueWithIdentifier:@"feedToSearchSegue" sender:nil];
}

- (void)didDoubleTap:(UITapGestureRecognizer*)gesture {
    NSLog(@"Fired");
    UIView* gestureView = gesture.view;
    UIImageView* heart = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"heart.fill"]];
    
    [heart setFrame:CGRectMake(0, 0, gestureView.frame.size.width / 4, gestureView.frame.size.height / 4)];
    [heart setTintColor:UIColor.whiteColor];
    [heart setCenter:gestureView.center];
    
    [gestureView addSubview:heart];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Code to be executed on the main queue after delay
        [UIView animateWithDuration:0.5 animations:^{
            [heart setAlpha:0];
        } completion:^(BOOL finished) {
            [heart removeFromSuperview];
        }];
    });
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    YelpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YelpCell" forIndexPath:indexPath];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
    self.tapGesture.numberOfTapsRequired = 2;
    
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
    
    [cell setUserInteractionEnabled:YES];
    [cell addGestureRecognizer:self.tapGesture];
        
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return TOP_NUM_RESULTS;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
