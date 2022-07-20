//
//  SearchViewController.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/12/22.
//

#import <UIKit/UIKit.h>
#import "MARKRangeSlider.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *ageRangeLabel;
@property (nonatomic, strong) MARKRangeSlider* rangeSlider;
@property(nonatomic, strong) NSMutableArray* criteria;
@property(nonatomic, strong) NSNumber* maxAge;
@property(nonatomic, strong) NSNumber* minAge;


@end

NS_ASSUME_NONNULL_END
