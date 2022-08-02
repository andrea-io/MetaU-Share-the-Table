//
//  main.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/6/22.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "YLPAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    NSString* YLPDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        YLPDelegateClassName = NSStringFromClass([YLPAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
