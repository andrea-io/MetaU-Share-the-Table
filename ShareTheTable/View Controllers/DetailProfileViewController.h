//
//  DetailProfileViewController.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/20/22.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PostDetailViewControllerDelegate
@end

@interface DetailProfileViewController : UIViewController

@property (nonatomic, strong) User *detailUser;
@property (weak, nonatomic) IBOutlet UILabel *detailUserFirstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailUserAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLocationLabel;
@property (nonatomic, strong) PFObject* conversation;

@property (nonatomic, weak) id<PostDetailViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
