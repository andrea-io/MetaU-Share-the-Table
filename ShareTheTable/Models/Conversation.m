//
//  Conversation.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/26/22.
//

#import "Conversation.h"
#import "UserInfo.h"
#import "Parse/Parse.h"

@implementation Conversation

@dynamic userOnePoint;
@dynamic userTwoPoint;
@dynamic convoMessages;

+ (nonnull NSString *)parseClassName {
    return @"Conversation";
}

- (nonnull NSMutableArray*) fetchCurrentConversationList: (UserInfo* _Nullable)currentUser {
    
    NSMutableArray* conversationList = [[NSMutableArray alloc] init];
    
    PFQuery* findCurrentUserQueryUserTwo = [PFQuery queryWithClassName:@"Conversation"];
    [findCurrentUserQueryUserTwo whereKey:@"userTwoInfoPointer" equalTo:currentUser];
    
    PFQuery* findCurrentUserQueryUserOne = [PFQuery queryWithClassName:@"Conversation"];
    [findCurrentUserQueryUserOne whereKey:@"userOneInfoPointer" equalTo:currentUser];
    
    PFQuery* combinedQuery = [PFQuery orQueryWithSubqueries:@[findCurrentUserQueryUserOne, findCurrentUserQueryUserTwo]];
    
    [conversationList addObjectsFromArray:[combinedQuery findObjects]];

    return conversationList;
}

- (nonnull NSMutableArray*) fetchConversationMessages: (NSString* _Nullable)conversationID {
    
    Conversation* conversation = [Conversation objectWithoutDataWithClassName:@"Conversation" objectId:conversationID];
    [conversation fetch];
    NSMutableArray* convoMessages = [[NSMutableArray alloc] init];

    [convoMessages addObjectsFromArray:conversation[@"messages"]];
    
    return convoMessages;
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
        NSLog(@"%@", convoObj);
        NSLog(@"%@", convoObj.objectId);
        [convoObj save];
       [self addUserToMatchesList:otherUser withCurrentUser:currentUser withConvo:convoObj];
        return convoObj.objectId;
    }
}
@end
