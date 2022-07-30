//
//  UserInfo.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/29/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) PFUser* userPointer;
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSNumber* ageValue;
@property (nonatomic, strong) NSString* locationName;
@property (nonatomic, strong) NSMutableArray* allPreferences;
@property (nonatomic, strong) NSMutableArray* userPhotos;
@property (nonatomic, strong) NSDictionary* currentMatches;

@end

NS_ASSUME_NONNULL_END
