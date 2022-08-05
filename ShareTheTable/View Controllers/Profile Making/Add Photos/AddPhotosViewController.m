//
//  AddPhotosViewController.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/7/22.
//

#import "AddPhotosViewController.h"
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>
#import "SceneDelegate.h"
#import "CreateAccountViewController.h"
#import "QuestionViewController.h"
#import "UniformTypeIdentifiers/UniformTypeIdentifiers.h"
#import "Parse/Parse.h"
#import "UserInfo.h"

@interface AddPhotosViewController () <PHPickerViewControllerDelegate>

@end

@implementation AddPhotosViewController

NSInteger const PHOTO_LIMIT = 5;

- (IBAction)tapNext:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    CreateAccountViewController *navViewController = [storyboard instantiateViewControllerWithIdentifier:@"QuestionNav"];
    sceneDelegate.window.rootViewController = navViewController;
}

- (IBAction)tapCancel:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    CreateAccountViewController *navViewController = [storyboard instantiateViewControllerWithIdentifier:@"AccountNav"];
    sceneDelegate.window.rootViewController = navViewController;
}

- (IBAction)tapSelectPhotos:(id)sender {
    PHPickerConfiguration *config = [[PHPickerConfiguration alloc] init];
    config.selectionLimit = PHOTO_LIMIT;
    config.filter = [PHPickerFilter imagesFilter];

    PHPickerViewController *pickerViewController = [[PHPickerViewController alloc] initWithConfiguration:config];
    pickerViewController.delegate = self;
    [self presentViewController:pickerViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageViews = [[NSMutableArray alloc] init];
}

-(UIImageView*)newImageViewForImage:(UIImage*)image {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor blackColor];
    imageView.image = image;
    return imageView;
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)picker:(nonnull PHPickerViewController *)picker didFinishPicking:(nonnull NSArray<PHPickerResult *> *)results {
    
    [picker dismissViewControllerAnimated:YES completion:nil];

    for (PHPickerResult *result in results) {
        // Get UIImage
        [result.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {

            if ([object isKindOfClass:[UIImage class]]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage* imageSelected = object;
                    imageSelected = [self resizeImage:imageSelected withSize:CGSizeMake(159,159)];
                    [self.imageViews addObject:imageSelected];
                    
                    if(self.imageViews.count == PHOTO_LIMIT) {
                        PFObject* currentUser = [PFUser currentUser];
                        PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
                        [query whereKey:@"userPointer" equalTo:currentUser];
                        UserInfo *userInfo = [query getFirstObject];
                        for(UIImage* image in self.imageViews) {
                            NSString* imageString = [UIImagePNGRepresentation(image) base64Encoding];
                
                            [userInfo addObject:imageString forKey:@"userPhotos"];
                            [userInfo saveInBackground];
                        }
                
                        [self.image1 setImage:[self.imageViews objectAtIndex:0]];
                        [self.image2 setImage:[self.imageViews objectAtIndex:1]];
                        [self.image3 setImage:[self.imageViews objectAtIndex:2]];
                        [self.image4 setImage:[self.imageViews objectAtIndex:3]];
                        [self.image5 setImage:[self.imageViews objectAtIndex:4]];
                    }

                    [self.view setNeedsLayout];
                });
            }

        }];
    }
}

@end
