//
//  ReceiverMessageCell.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 8/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceiverMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageBodyText;
@property (weak, nonatomic) IBOutlet UIImageView *messageUserImage;
@property (weak, nonatomic) IBOutlet UILabel *messageUserName;

@end

NS_ASSUME_NONNULL_END
