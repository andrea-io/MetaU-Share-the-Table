//
//  YelpCell.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 8/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YelpCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *restaurantLocation;

@property (weak, nonatomic) IBOutlet UIImageView *restaurantImageView;

@property (weak, nonatomic) IBOutlet UILabel *restaurantName;

@end

NS_ASSUME_NONNULL_END
