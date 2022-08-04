//
//  UserInfo.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/29/22.
//

#import "UserInfo.h"

@implementation UserInfo

@dynamic userPointer;
@dynamic username;
@dynamic userPhotos;
@dynamic firstName;
@dynamic ageValue;
@dynamic locationName;
@dynamic allPreferences;
@dynamic currentMatches;

+ (nonnull NSString *)parseClassName {
    return @"UserInfo";
}

- (nonnull NSMutableArray*) fetchCurrentConversationList: (UserInfo* _Nullable)currentUser {
    
    NSMutableArray* conversationList = [[NSMutableArray alloc] init];
    
    PFQuery* findCurrentUserQueryUserTwo = [PFQuery queryWithClassName:@"Conversation"];
    [findCurrentUserQueryUserTwo whereKey:@"userInfoTwoPointer" equalTo:currentUser];
    
    PFQuery* findCurrentUserQueryUserOne = [PFQuery queryWithClassName:@"Conversation"];
    [findCurrentUserQueryUserOne whereKey:@"userInfoOnePointer" equalTo:currentUser];
    
    PFQuery* combinedQuery = [PFQuery orQueryWithSubqueries:@[findCurrentUserQueryUserOne, findCurrentUserQueryUserTwo]];
    
    [conversationList addObjectsFromArray:[combinedQuery findObjects]];

    return conversationList;
}

- (void) deleteUserFromMatchesList: (UserInfo* _Nullable)otherUser withCurrentUser:( UserInfo* _Nullable) currentUser withConvo: (Conversation* _Nullable)conversation {
    
    // Look for previous currentMatches dictionaries info
    NSMutableDictionary *currentUserDict = [[NSMutableDictionary alloc] initWithDictionary:currentUser[@"currentMatches"]];
    NSMutableDictionary *otherUserDict = [[NSMutableDictionary alloc] initWithDictionary:otherUser[@"currentMatches"]];
    
    // Delete the two user's match with each other
    [currentUserDict removeObjectForKey:otherUser.objectId];
    [otherUserDict removeObjectForKey:currentUser.objectId];
    
    // Also delete the conversation itself
    PFQuery* query = [PFQuery queryWithClassName:@"Conversation"];
    [query whereKey:@"objectId" equalTo:conversation.objectId];
    PFObject* object = [query findObjects][0];
    [object delete];
    
    // Reassign the dictionaries to each user
    currentUser[@"currentMatches"] = currentUserDict;
    otherUser[@"currentMatches"] = otherUserDict;
    
    [currentUser save];
    [otherUser save];
}

- (void) addUserToMatchesList: (UserInfo* _Nullable)otherUser withCurrentUser:( UserInfo* _Nullable) currentUser withConvo: (Conversation* _Nullable)conversation {
    
    // Look for previous currentMatches dictionaries info
    NSMutableDictionary *currentUserDict = [[NSMutableDictionary alloc] initWithDictionary:currentUser[@"currentMatches"]];
    NSMutableDictionary *otherUserDict = [[NSMutableDictionary alloc] initWithDictionary:otherUser[@"currentMatches"]];
    
    // Set new object to be placed into that dictionary
    [currentUserDict setObject:conversation.objectId forKey:otherUser.objectId];
    [otherUserDict setObject:conversation.objectId forKey:currentUser.objectId];
   
    // Reassign the dictionaries to each user
    currentUser[@"currentMatches"] = currentUserDict;
    otherUser[@"currentMatches"] = otherUserDict;
    
    [currentUser save];
    [otherUser save];
}

- (nonnull NSString* ) checkIfConversationExists: (UserInfo* _Nullable )otherUser withCurrentUser: (UserInfo* _Nullable )currentUser {
    
    // Check if otherUser is in dictionary of currentUser
    // If so, retrieve that conversation ID and return
    // If not, create new Conversation object like below and use the addUserTomatcheslist func
    
    if([currentUser[@"currentMatches"] objectForKey:otherUser.objectId] != nil) {
        return [currentUser.currentMatches objectForKey:otherUser.objectId];
    } else {

        Conversation* convoObj = [Conversation new];
        convoObj[@"userInfoOnePointer"] = currentUser;
        convoObj[@"userInfoTwoPointer"] = otherUser;
        [convoObj save];
        
        [self addUserToMatchesList:otherUser withCurrentUser:currentUser withConvo:convoObj];
        return convoObj.objectId;
    }
}

@end
