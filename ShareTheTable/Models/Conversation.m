//
//  Conversation.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/26/22.
//

#import "Conversation.h"
#import "User.h"
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
    
    PFQuery* messagesQuery = [PFQuery queryWithClassName:@"Conversation"];
    
    NSMutableArray* convoMessages = [[NSMutableArray alloc] init];
    [convoMessages addObjectsFromArray:[messagesQuery findObjects]];
    
    return convoMessages;
}

- (void) addUserToMatchesList: (PFObject* _Nullable)otherUser withCurrentUser:( PFObject* _Nullable) currentUser withConvo: (Conversation* _Nullable)conversation {
    
    User* current = [User objectWithoutDataWithObjectId:currentUser.objectId];
    User* other = [User objectWithoutDataWithObjectId:otherUser.objectId];
    NSLog(@"%@", current);
    NSLog(@"%@", other);
    NSLog(@"%@", conversation.objectId);
    
    current[@"currentMatches"] = [NSDictionary dictionaryWithObject:conversation.objectId forKey:otherUser.objectId];
    other[@"currentMatches"] = [NSDictionary dictionaryWithObject:conversation.objectId forKey:currentUser.objectId];
}

- (nonnull NSString* ) checkIfConversationExists: (PFObject* _Nullable )otherUser withCurrentUser: (PFObject* _Nullable )currentUser {
    
    // Check if otherUser is in dictionary of currentUser
    // If so, retrieve that conversation ID and return
    // If not, create new Conversation object like below and use the addUserTomatcheslist func
    PFObject* user = PFUser.currentUser;
    NSLog(@"%@", user);
    
    PFQuery* userQuery = [PFQuery queryWithClassName:@"_User"];
    [userQuery whereKey:@"objectId" equalTo:user.objectId];
    
    NSArray* test = [userQuery findObjects];
    NSLog(@"%@", test);
    
    User* current = test[0];
    
    Conversation* convoObj = [[Conversation new] initWithClassName:@"Conversation"];
    convoObj.userOnePoint = currentUser;
    convoObj.userTwoPoint = otherUser;
    
    [convoObj saveInBackground];
//    PFObject* convo = [PFObject objectWithClassName:@"Conversation"];
//    convo[@"userOnePointer"] = currentUser;
//    convo[@"userTwoPointer"] = otherUser;
//
//    [convo saveInBackground];
    NSLog(@"%@", convoObj);
    NSLog(@"%@", convoObj.objectId);
    
    //Conversation* convoObj = [Conversation objectWithoutDataWithObjectId:convo.objectId];
    
    if([current[@"currentMatches"] objectForKey:otherUser.objectId] != nil) {
        return [current.currentMatches objectForKey:otherUser.objectId];
    } else {
//        Conversation* convoObj = [[Conversation alloc] init];
//
//        convoObj[@"userOnePointer"] = currentUser;
//        convoObj[@"userTwoPointer"] = otherUser;
//
//        [convoObj saveInBackground];
        
        [self addUserToMatchesList:otherUser withCurrentUser:currentUser withConvo:convoObj];
        return convoObj.objectId;
    }
    
    // Create a query predicate where otherUser objectID is either found in the userOne or userTwo column of the Conversation database
    
//    NSLog(@"otherUser: %@", otherUser.objectId);
//    NSLog(@"currentUser: %@", currentUser.objectId);
//    PFQuery* findOtherUserQueryUserTwo = [PFQuery queryWithClassName:@"Conversation"];
//    [findOtherUserQueryUserTwo whereKey:@"userTwoPointer" equalTo:otherUser];
//    [findOtherUserQueryUserTwo whereKey:@"userOnePointer" equalTo:currentUser];
//
    //PFQuery* findOtherUserQueryUserOne = [PFQuery queryWithClassName:@"Conversation"];
    //[findOtherUserQueryUserOne whereKey:@"userOnePointer" equalTo:otherUser];
    
    //PFQuery* otherUserExistence = [PFQuery orQueryWithSubqueries:@[findOtherUserQueryUserOne, findOtherUserQueryUserTwo]];
    
    // Using the query results, create another query where the PFUser Current User objectID is either found in the userOne or userTwo column of the Conversation database
    
//    PFQuery* findCurrentUserQueryUserTwo = [PFQuery queryWithClassName:@"Conversation"];
//    [findCurrentUserQueryUserTwo whereKey:@"userTwoPointer" equalTo:currentUser];
//    [findCurrentUserQueryUserTwo whereKey:@"userOnePointer" equalTo:otherUser];
//
    
    
    //PFQuery* findCurrentUserQueryUserOne = [PFQuery queryWithClassName:@"Conversation"];
    //[findOtherUserQueryUserOne whereKey:@"userOnePointer" equalTo:currentUser];
    
    //PFQuery* currentUserExistence = [PFQuery orQueryWithSubqueries:@[findCurrentUserQueryUserOne, findCurrentUserQueryUserTwo]];
    
    // Check to see if there exists 1 conversation object containing both users
//    PFQuery* finalQuery = [PFQuery orQueryWithSubqueries:@[findOtherUserQueryUserTwo, findCurrentUserQueryUserTwo]];
//
//     Conversation* convo = [[Conversation alloc] init];
//
//    [finalQuery findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError *error) {
//        // If the final query results in an object:
//        // Retrieve that Conversation objectID and segue to Conversation View Controller.
//        // Call the helper function fetchConversationMessages
//
//        if (objects != nil) {
//            convo = objects[0];
//        } else {
//
//            // If the final query is empty and does not have objects:
//            // Create a new Conversation object where userOneID == PFUser Current User objectID. And userTwoID == otherUser objectID
//            // Store that Conversation objectID and segue to Conversation View Controller
//
//            convo[@"userOnePointer"] = currentUser;
//            convo[@"userTwoPointer"] = otherUser;
//        }
//    }];
    
    ///////////////
//    NSArray *objects = [finalQuery findObjects];
//    if (objects.count > 0) {
//        convo = objects[0];
//    } else {
//        convo[@"userOnePointer"] = currentUser;
//        convo[@"userTwoPointer"] = otherUser;
//    }
    ////////////////
    
    // If the final query is empty and does not have objects:
    // Create a new Conversation object where userOneID == PFUser Current User objectID. And userTwoID == otherUser objectID
    // Store that Conversation objectID and segue to Conversation View Controller

    //return convo.objectId;
}
@end
