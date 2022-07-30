//
//  UserInfo.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/29/22.
//

#import "UserInfo.h"

@implementation UserInfo

@dynamic userPointer;
@dynamic username;
@dynamic userPhotos;
@dynamic firstName;
@dynamic ageValue;
@dynamic locationName;
@dynamic allPreferences;
@dynamic currentMatches;

+ (nonnull NSString *)parseClassName {
    return @"UserInfo";
}

@end
