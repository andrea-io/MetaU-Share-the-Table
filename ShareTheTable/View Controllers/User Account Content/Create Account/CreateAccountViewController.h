//
//  CreateAccountViewController.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreateAccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

//@property (weak, nonatomic) IBOutlet UITextField *ageTextView;
//@property (weak, nonatomic) IBOutlet UITextField *locationTextView;
//@property (weak, nonatomic) IBOutlet UITextField *firstNameTextView;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;
//@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;
//@property (weak, nonatomic) IBOutlet UITextField *usernameTextView;

@end

NS_ASSUME_NONNULL_END
