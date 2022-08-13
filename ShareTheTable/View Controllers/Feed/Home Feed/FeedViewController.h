//
//  FeedViewController.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/6/22.
//

#import <UIKit/UIKit.h>
@class YLPClient;
@class YLPSearch;
@class YLPCoordinate;
@import YelpAPI;
@import CoreLocation;
#import "Parse/Parse.h"
#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *logOutButton;
@property (weak, nonatomic) IBOutlet UITableView *yelpTableView;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewProfileButton;
@property (strong, nonatomic) NSMutableArray* places;
@property (nonatomic) YLPSearch *search;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) UserInfo* currentUserInfo;

@end

NS_ASSUME_NONNULL_END
