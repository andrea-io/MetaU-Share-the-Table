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

- (nonnull NSMutableArray*) fetchCurrentConversationList: (PFObject* _Nullable)currentUser {
    
    NSMutableArray* conversationList = [[NSMutableArray alloc] init];
    
    PFQuery* findCurrentUserQueryUserTwo = [PFQuery queryWithClassName:@"Conversation"];
    [findCurrentUserQueryUserTwo whereKey:@"userTwoPointer" equalTo:currentUser];
    
    PFQuery* findCurrentUserQueryUserOne = [PFQuery queryWithClassName:@"Conversation"];
    [findCurrentUserQueryUserOne whereKey:@"userOnePointer" equalTo:currentUser];
    
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
    
    NSLog(@"%@", conversation.objectId);
    
    currentUser[@"currentMatches"] = [NSDictionary dictionaryWithObject:conversation.objectId forKey:otherUser.objectId];
    otherUser[@"currentMatches"] = [NSDictionary dictionaryWithObject:conversation.objectId forKey:currentUser.objectId];
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
