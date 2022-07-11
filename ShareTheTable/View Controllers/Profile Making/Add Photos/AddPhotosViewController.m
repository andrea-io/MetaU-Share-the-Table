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

@interface AddPhotosViewController () <PHPickerViewControllerDelegate>


@end

@implementation AddPhotosViewController

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
    
    // TODO: DELETE ACCOUNT MADE
}

- (IBAction)tapSelectPhotos:(id)sender {
    // self.imageViews = [[NSMutableArray alloc] init];
    PHPickerConfiguration *config = [[PHPickerConfiguration alloc] init];
    config.selectionLimit = 5;
    config.filter = [PHPickerFilter imagesFilter];

    PHPickerViewController *pickerViewController = [[PHPickerViewController alloc] initWithConfiguration:config];
    pickerViewController.delegate = self;
    [self presentViewController:pickerViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageViews = [[NSMutableArray alloc] init];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        NSLog(@"result: %@", result);
        NSLog(@"%@", result.assetIdentifier);
        NSLog(@"%@", result.itemProvider);
        
        // Get UIImage
        [result.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {

            NSLog(@"object: %@, error: %@", object, error);
            if ([object isKindOfClass:[UIImage class]]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //UIImageView *imageView = [self newImageViewForImage:(UIImage*)object];
                    UIImage* img = object;
                    img = [self resizeImage:img withSize:CGSizeMake(159,159)];
                    
                    [self.imageViews addObject:img];
                    if(self.imageViews.count == 5) {
                        PFObject* currentUser = [PFUser currentUser];
                        for(UIImage* image in self.imageViews) {
                            NSData *imageData = UIImageJPEGRepresentation(image, .7);
                            [currentUser addObject:imageData forKey:@"userPhotos"];
                            [currentUser saveInBackground];
                        }
                
                        [self.image1 setImage:[self.imageViews objectAtIndex:0] forState:UIControlStateNormal];
                        [self.image2 setImage:[self.imageViews objectAtIndex:1] forState:UIControlStateNormal];
                        [self.image3 setImage:[self.imageViews objectAtIndex:2] forState:UIControlStateNormal];
                        [self.image4 setImage:[self.imageViews objectAtIndex:3] forState:UIControlStateNormal];
                        [self.image5 setImage:[self.imageViews objectAtIndex:4] forState:UIControlStateNormal];
                    }

                    [self.view setNeedsLayout];
                });
            }

        }];
    }
}

@end
