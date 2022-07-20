//
//  User.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/7/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString* userID;
@property (nonatomic, strong) PFUser* user;
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSNumber* ageValue;
@property (nonatomic, strong) NSString* location;

+ (void) pushUserToFeed: ( PFUser * _Nullable )user withName: ( NSString * _Nullable )firstName withAge: (NSNumber * _Nullable)ageValue withLocation: (NSString * _Nullable)location withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
