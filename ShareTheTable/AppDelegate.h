//
//  AppDelegate.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/6/22.
//

#import <UIKit/UIKit.h>
@class YLPClient;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

+ (YLPClient *)sharedClient;

@end

