//
//  UserCell.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *userAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userFirstNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userMainPhotoImageView;

@end

NS_ASSUME_NONNULL_END
