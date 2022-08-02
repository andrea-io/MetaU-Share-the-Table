//
//  AppDelegate.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/6/22.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
@import YelpAPI;

@interface AppDelegate ()

@property (strong, nonatomic) YLPClient *client;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Keys" ofType: @"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];

        NSString* App_ID = [dict objectForKey: @"App_ID"];
        NSString* Client_Key = [dict objectForKey: @"Client_Key"];
    
    // Connecting app to database through parse configuration
    ParseClientConfiguration *config = [ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = App_ID;
        configuration.clientKey = Client_Key;
        configuration.server = @"https://parseapi.back4app.com";
    }];

    [Parse initializeWithConfiguration:config];
    
    // Initialize Yelp API Client
    self.client = [[YLPClient alloc] initWithAPIKey:@"hwQOBFeyaIltgmj38TBwgw0N6yYvFEAVPy0Vn1vJjG5n71vYM8dQpAnLmwHqIca2RZXnrYXe_xThpkPo6uSFnMDujjG9_xUr0n4M35cu7Qax64i6sENqvJsaMUjpYnYx"];
    
    return YES;
}

+ (YLPClient *)sharedClient {
    AppDelegate* appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.client;
}


#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
