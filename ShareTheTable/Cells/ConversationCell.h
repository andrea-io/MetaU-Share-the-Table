//
//  ConversationCell.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/26/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConversationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *conversationUserImage;
@property (weak, nonatomic) IBOutlet UILabel *conversationUserName;


@end

NS_ASSUME_NONNULL_END
