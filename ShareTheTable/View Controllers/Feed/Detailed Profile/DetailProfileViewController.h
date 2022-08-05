//
//  DetailProfileViewController.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/20/22.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PostDetailViewControllerDelegate
@end

@interface DetailProfileViewController : UIViewController

@property (nonatomic, strong) UserInfo *detailUser;
@property (weak, nonatomic) IBOutlet UILabel *detailUserFirstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailUserAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLocationLabel;
@property (nonatomic, strong) PFObject* conversation;
@property (weak, nonatomic) IBOutlet UILabel *cuisinesList;
@property (weak, nonatomic) IBOutlet UILabel *dietaryRestrictionsList;

@property (nonatomic, weak) id<PostDetailViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *detailUserPhotoOne;
@property (weak, nonatomic) IBOutlet UIImageView *detailUserPhotoTwo;
@property (weak, nonatomic) IBOutlet UIImageView *detailUserPhotoThree;
@property (weak, nonatomic) IBOutlet UIImageView *detailUserPhotoFour;
@property (weak, nonatomic) IBOutlet UIImageView *detailUserPhotoFive;


@end

NS_ASSUME_NONNULL_END
