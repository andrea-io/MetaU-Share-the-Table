//
//  User.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/7/22.
//

#import "User.h"

@implementation User

@dynamic userID;
@dynamic user;
@dynamic firstName;
@dynamic ageValue;
@dynamic location;

+ (nonnull NSString *)parseClassName {
    return @"User";
}

+ (void) pushUserToFeed: ( PFUser * _Nullable )user withName: ( NSString * _Nullable )firstName withAge: (NSNumber * _Nullable)ageValue withLocation: (NSString * _Nullable)location withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    User *newUser = [User new];
    newUser.user = [PFUser currentUser];
    newUser.firstName = firstName;
    newUser.ageValue = ageValue;
    newUser.location = location;
    
    [newUser saveInBackgroundWithBlock: completion];
}

@end
