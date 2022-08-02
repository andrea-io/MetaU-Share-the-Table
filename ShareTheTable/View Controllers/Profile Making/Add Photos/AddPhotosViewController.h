//
//  AddPhotosViewController.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/7/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddPhotosControllerDelegate
@end

@interface AddPhotosViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *image5;
@property (weak, nonatomic) IBOutlet UIButton *image4;
@property (weak, nonatomic) IBOutlet UIButton *image3;
@property (weak, nonatomic) IBOutlet UIButton *image2;
@property (weak, nonatomic) IBOutlet UIButton *image1;
@property (weak, nonatomic) IBOutlet UIButton *selectPhotosButton;
@property (nonatomic, strong) NSMutableArray* imageViews;

@end

NS_ASSUME_NONNULL_END
