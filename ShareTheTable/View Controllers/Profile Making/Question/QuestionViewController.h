//
//  QuestionViewController.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/7/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuestionViewController : UIViewController

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
@property (nonatomic, strong) NSMutableArray* dietaryRestrictions;
@property (nonatomic, strong) NSMutableArray* cuisinePreferences;


@end

NS_ASSUME_NONNULL_END
