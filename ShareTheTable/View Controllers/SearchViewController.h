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

@property (weak, nonatomic) IBOutlet UIButton *otherFoodButton;
@property (weak, nonatomic) IBOutlet UIButton *greekFoodButton;
@property (weak, nonatomic) IBOutlet UIButton *italianFoodButton;
@property (weak, nonatomic) IBOutlet UIButton *americanFoodButton;
@property (weak, nonatomic) IBOutlet UIButton *mexicanFoodButton;
@property (weak, nonatomic) IBOutlet UIButton *chineseFoodButton;
@property (weak, nonatomic) IBOutlet UIButton *seaFoodAllergiesButton;
@property (weak, nonatomic) IBOutlet UIButton *lactoseIntolerantButton;
@property (weak, nonatomic) IBOutlet UIButton *glutenFreeButton;
@property (weak, nonatomic) IBOutlet UIButton *kosherButton;
@property (weak, nonatomic) IBOutlet UIButton *vegitarianButton;
@property (weak, nonatomic) IBOutlet UIButton *veganButton;

@end

NS_ASSUME_NONNULL_END
