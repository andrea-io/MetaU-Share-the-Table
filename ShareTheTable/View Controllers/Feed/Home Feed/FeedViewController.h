//
//  FeedViewController.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *yelpTableView;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewProfileButton;
@property (strong, nonatomic) NSMutableArray* places;

@end

NS_ASSUME_NONNULL_END
