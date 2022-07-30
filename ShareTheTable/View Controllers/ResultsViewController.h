//
//  ResultsViewController.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (nonatomic, strong) NSMutableArray *arrayOfUsers;
@property(nonatomic, strong) NSNumber* maxAge;
@property(nonatomic, strong) NSNumber* minAge;

@end

NS_ASSUME_NONNULL_END
