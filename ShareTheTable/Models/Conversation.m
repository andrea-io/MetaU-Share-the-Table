//
//  Conversation.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/26/22.
//

#import "Conversation.h"

@implementation Conversation

@dynamic userOnePointer;
@dynamic userTwoPointer;
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

+ (nonnull NSMutableArray*) fetchConversationMessages: (NSString* _Nullable)conversationID {
    
    PFQuery* messagesQuery = [PFQuery queryWithClassName:@"Conversation"];
    
    NSMutableArray* convoMessages = [[NSMutableArray alloc] init];
    [convoMessages addObjectsFromArray:[messagesQuery findObjects]];
    
    return convoMessages;
}

+ (nonnull NSString* ) checkIfConversationExists: (PFUser* _Nullable )otherUser withCurrentUser: (PFUser* _Nullable )currentUser {
    
    // Create a query predicate where otherUser objectID is either found in the userOne or userTwo column of the Conversation database
    
    PFQuery* findOtherUserQueryUserTwo = [PFQuery queryWithClassName:@"Conversation"];
    [findOtherUserQueryUserTwo whereKey:@"userTwoPointer" equalTo:otherUser];
    
    PFQuery* findOtherUserQueryUserOne = [PFQuery queryWithClassName:@"Conversation"];
    [findOtherUserQueryUserOne whereKey:@"userOnePointer" equalTo:otherUser];
    
    PFQuery* otherUserExistence = [PFQuery orQueryWithSubqueries:@[findOtherUserQueryUserOne, findOtherUserQueryUserTwo]];
    
    // Using the query results, create another query where the PFUser Current User objectID is either found in the userOne or userTwo column of the Conversation database
    
    PFQuery* findCurrentUserQueryUserTwo = [PFQuery queryWithClassName:@"Conversation"];
    [findOtherUserQueryUserTwo whereKey:@"userTwoPointer" equalTo:currentUser];
    
    PFQuery* findCurrentUserQueryUserOne = [PFQuery queryWithClassName:@"Conversation"];
    [findOtherUserQueryUserOne whereKey:@"userOnePointer" equalTo:currentUser];
    
    PFQuery* currentUserExistence = [PFQuery orQueryWithSubqueries:@[findCurrentUserQueryUserOne, findCurrentUserQueryUserTwo]];
    
    // Check to see if there exists 1 conversation object containing both users
    PFQuery* finalQuery = [PFQuery orQueryWithSubqueries:@[currentUserExistence, otherUserExistence]];
    
    __block Conversation* convo = [[Conversation alloc] init];
    
    [finalQuery findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError *error) {
        // If the final query results in an object:
        // Retrieve that Conversation objectID and segue to Conversation View Controller.
        // Call the helper function fetchConversationMessages

        if (objects != nil) {
            convo = [objects firstObject];
        } else {
            
            // If the final query is empty and does not have objects:
            // Create a new Conversation object where userOneID == PFUser Current User objectID. And userTwoID == otherUser objectID
            // Store that Conversation objectID and segue to Conversation View Controller
            
            convo[@"userOnePointer"] = currentUser;
            convo[@"userTwoPointer"] = otherUser;
        }
    }];
    
    // If the final query is empty and does not have objects:
    // Create a new Conversation object where userOneID == PFUser Current User objectID. And userTwoID == otherUser objectID
    // Store that Conversation objectID and segue to Conversation View Controller

    return convo.objectId;
}
@end
