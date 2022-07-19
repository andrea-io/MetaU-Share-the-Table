//
//  SelfProfileViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/8/22.
//

#import "SelfProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Parse/Parse.h"
//#import "NSData+Base64.h"

@interface SelfProfileViewController ()

@end

@implementation SelfProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profileImage1.layer.cornerRadius = 5;
    self.profileImage1.clipsToBounds = YES;
    self.profileImage2.layer.cornerRadius = 5;
    self.profileImage2.clipsToBounds = YES;
    self.profileImage3.layer.cornerRadius = 5;
    self.profileImage3.clipsToBounds = YES;
    self.profileImage4.layer.cornerRadius = 5;
    self.profileImage4.clipsToBounds = YES;
    self.profileImage5.layer.cornerRadius = 5;
    self.profileImage5.clipsToBounds = YES;
                             
    PFObject* currentUser = [PFUser currentUser];
    //NSString *imageString = [currentUser[@"userPhotos"] objectAtIndex:0];
    
    
//    NSMutableArray* photoViews = [[NSMutableArray alloc] init];
//    photoViews = [NSMutableArray arrayWithObjects:self.profileImage1.image, self.profileImage2.image, self.profileImage3.image, self.profileImage4.image, self.profileImage5.image];
//
//    NSEnumerator* photoEnumerator = [photos objectEnumerator];
//    int count = 0;
//    while(imageString = [photoEnumerator nextObject]) {
//        NSData* data = [NSData dataFromBase64String:[photoEnumerator nextObject]];
//        UIImage* recoverImage = [UIImage imageWithData:data];
//        photoViews[count] = recoverImage;
//        count++;
//    }
//    for(NSString* imageString in currentUser[@"userPhotos"]) {
//        NSData *data = [NSData dataFromBase64String:imageString];
//        UIImage *recoverImage = [UIImage imageWithData:data];
//        self.profileImage1.image = recoverImage;
//    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
