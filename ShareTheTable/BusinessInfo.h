//
//  BusinessInfo.h
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 8/2/22.
//

#ifndef BusinessInfo_h
#define BusinessInfo_h

@interface BusinessInfo : NSObject

- (nonnull NSMutableArray*) fetchBusinesses: (double)latitude withLongitude: (double)longitude withLimit: (NSInteger)limit;

@end


#endif /* BusinessInfo_h */
