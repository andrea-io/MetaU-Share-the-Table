//
//  BusinessInfo.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 8/2/22.
//

#import <Foundation/Foundation.h>

#import "BusinessInfo.h"

@implementation BusinessInfo : NSObject

struct BusinessObj {
    // name
    NSString* name;
    // categories
    NSArray* categories;
    // rating
    NSNumber* rating;
    // location
    NSObject* location;
};

- (nonnull NSMutableArray*) fetchBusinesses: (double)latitude withLongitude: (double)longitude withLimit: (NSInteger)limit {
    
    NSString* API_KEY = @"hwQOBFeyaIltgmj38TBwgw0N6yYvFEAVPy0Vn1vJjG5n71vYM8dQpAnLmwHqIca2RZXnrYXe_xThpkPo6uSFnMDujjG9_xUr0n4M35cu7Qax64i6sENqvJsaMUjpYnYx";
    
    NSString* BASE_URL = [@"https://api.yelp.com/v3/businesses/search?" stringByAppendingFormat:@"latitude=%1.2f&longitude=%1.2f&limit=%ld", latitude, longitude, limit];
    
    NSURL* URL = [NSURL URLWithString:BASE_URL];
    
    NSMutableURLRequest* REQUEST = [NSMutableURLRequest requestWithURL:URL];
    
    [REQUEST setValue:[@"Bearer " stringByAppendingString:API_KEY] forHTTPHeaderField:@"Authorization"];
    [REQUEST setHTTPMethod:@"GET"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    // Configure the session here.
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    [session dataTaskWithRequest:REQUEST completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        @try {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary* businesses = [json valueForKey:@"businesses"];
                        
            for(id buisness in businesses) {
                struct BusinessObj placeFound;
                
                placeFound.name = [buisness valueForKey:@"name"];
                placeFound.location = [buisness valueForKey:@"location.address1"];
                placeFound.categories = [buisness valueForKey:@"categories"];
                placeFound.rating = [buisness valueForKey:@"rating"];
                
                NSLog(@"%@", placeFound.name);
            }
            
        } @catch (id exception) {
            NSLog(@"%@", exception);
        };
        
    }];
    NSMutableArray* idk = [NSMutableArray new];
    return idk;
}

@end
