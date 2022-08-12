//
//  DetailProfileViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/20/22.
//

#import "DetailProfileViewController.h"
#import "ConversationViewController.h"
#import "Conversation.h"
#import <QuartzCore/QuartzCore.h>

@interface DetailProfileViewController ()

@end

@implementation DetailProfileViewController
NSInteger const CUISINE_TYPE_TAG = 2;
NSInteger const DIETARY_RESTRICTION_TYPE_TAG = 1;
NSInteger const PHOTO_COUNT = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray* detailUserPreferences = self.detailUser[@"allPreferences"];
    
    self.cuisinesList.text = @"";
    self.dietaryRestrictionsList.text = @"";
    
    for(PFObject* pref in detailUserPreferences) {
        [pref fetch];
        NSNumber* prefTypeIDNum = [pref valueForKey:@"typeID"];
        int prefTypeID = [prefTypeIDNum intValue];
        
        if(prefTypeID == CUISINE_TYPE_TAG) {
            self.cuisinesList.text = [self.cuisinesList.text stringByAppendingString:[pref[@"preferenceName"] stringByAppendingString:@" "]];
        } else {
            self.dietaryRestrictionsList.text = [self.dietaryRestrictionsList.text stringByAppendingString:[pref[@"preferenceName"] stringByAppendingString:@" "]];
        }
    }
    
    NSMutableArray* detailUserPhotoImageObjects = [[NSMutableArray alloc] init];
    
    for(NSString* imageString in self.detailUser.userPhotos) {
        NSData* imageData = [[NSData alloc] initWithBase64Encoding:imageString];
        
        UIImage* image = [UIImage imageWithData:imageData];
        
        [detailUserPhotoImageObjects addObject:image];
    }
    
    // Assign photos
    self.detailUserPhotoOne.layer.cornerRadius = 10.0;
    self.detailUserPhotoOne.clipsToBounds = YES;
    
    self.detailUserPhotoOne.image = [detailUserPhotoImageObjects objectAtIndex:0];
    
    self.detailUserPhotoTwo.layer.cornerRadius = 10.0;
    self.detailUserPhotoTwo.clipsToBounds = YES;
    
    self.detailUserPhotoTwo.image = [detailUserPhotoImageObjects objectAtIndex:1];
    
    self.detailUserPhotoThree.layer.cornerRadius = 10.0;
    self.detailUserPhotoThree.clipsToBounds = YES;
    
    self.detailUserPhotoThree.image = [detailUserPhotoImageObjects objectAtIndex:2];
    
    self.detailUserPhotoFour.layer.cornerRadius = 10.0;
    self.detailUserPhotoFour.clipsToBounds = YES;
    
    self.detailUserPhotoFour.image = [detailUserPhotoImageObjects objectAtIndex:3];
    
    self.detailUserPhotoFive.layer.cornerRadius = 10.0;
    self.detailUserPhotoFive.clipsToBounds = YES;
    
    self.detailUserPhotoFive.image = [detailUserPhotoImageObjects objectAtIndex:4];

    // Set up all other text labels
    self.detailUserFirstNameLabel.text = self.detailUser.firstName;
    self.detailUserAgeLabel.text = [self.detailUser.ageValue stringValue];
    self.detailLocationLabel.text = self.detailUser.locationName;
}

- (IBAction)didTapMessageUser:(id)sender {
    [self performSegueWithIdentifier:@"profileToMessageSegue" sender:self.detailUser];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"profileToMessageSegue"]) {
        UserInfo* otherUser = sender;
        UINavigationController *navigationController = segue.destinationViewController;
                ConversationViewController* convoVC = (ConversationViewController*) navigationController.topViewController;
        [convoVC setOtherUser:otherUser];
    }
}


@end
