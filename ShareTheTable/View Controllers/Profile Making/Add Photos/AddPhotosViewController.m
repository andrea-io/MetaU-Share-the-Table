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

- (void)picker:(nonnull PHPickerViewController *)picker didFinishPicking:(nonnull NSArray<PHPickerResult *> *)results {
    
    [picker dismissViewControllerAnimated:YES completion:nil];

    for (PHPickerResult *result in results) {
        NSLog(@"result: %@", result);
        NSLog(@"%@", result.assetIdentifier);
        NSLog(@"%@", result.itemProvider);
        
        [result.itemProvider loadItemForTypeIdentifier:result.assetIdentifier options:nil completionHandler:^(id item, NSError *error) {
            
            NSLog(@"%@", item);
            NSLog(@"%@", [item class]);
            
            if([item isKindOfClass:[NSURL class]]) {
                //NSError *error = nil;
                NSData *data = [NSData dataWithContentsOfURL:item];
                UIImage *image = [UIImage imageWithData:data];
                [self.imageViews addObject:image];
            }
            self.imagetest1.image = [self.imageViews objectAtIndex:0];
            //self.imagetest2.image = [self.imageViews objectAtIndex:1];
        }];
        
        // Get UIImage
//        [result.itemProvider loadObjectOfClass:[NSURL class] completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
//
//            NSLog(@"object: %@, error: %@", object, error);
//            if ([object isKindOfClass:[NSURL class]]) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //UIImageView *imageView = [self newImageViewForImage:(UIImage*)object];
//                    NSData *data = [[NSData alloc] initWithContentsOfURL:object];
//
//                    UIImage *image = [UIImage imageWithData:data];
//
//                    [self.imageViews addObject:image];
//                    self.imagetest1.image = image;
//
//                    [self.view setNeedsLayout];
//                });
//            }
//
//        }];
    }
    
    for (id obj in self.imageViews) {
        NSLog(@"obj: %@", obj);
    }
    
   
//    [self.imagetest1 setImage:[self.images objectAtIndex:0]];
//    [self.imagetest2 setImage:[self.images objectAtIndex:1]];
}

@end
