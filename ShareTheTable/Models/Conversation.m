//
//  Conversation.m
//  ShareTheTable
//
//  Created by Andrea Gonzalez on 7/26/22.
//

#import "Conversation.h"

@implementation Conversation

@dynamic userOneID;
@dynamic userTwoID;
@dynamic convoMessages;

+ (nonnull NSString *)parseClassName {
    return @"Conversation";
}

+ (nonnull NSMutableArray*) fetchCurrentConversationList: (NSString* _Nullable)currentUserID {
    NSPredicate* predOther = [NSPredicate predicateWithFormat:@"%@ IN userTwo OR %@ IN userOne", currentUserID];
    
    NSMutableArray* conversationList = [[NSMutableArray alloc] init];
    PFQuery* findCurrentUserQuery = [PFQuery queryWithClassName:@"Conversation" predicate:predOther];
    
    [findCurrentUserQuery findObjectsInBackgroundWithBlock:^(NSArray* _Nullable objects, NSError* _Nullable error) {
        if(error != nil) {
            NSLog(@"%@", error.observationInfo);
        } else {
            [conversationList addObjectsFromArray:objects];
        }
    }];
    
    return conversationList;
}

+ (nonnull NSMutableArray*) fetchConversationMessages: (NSString* _Nullable)conversationID {
    
    PFQuery* query = [PFQuery queryWithClassName:@"Conversation"];
    
    __block NSMutableArray* convoMessages;
    
    [query getObjectInBackgroundWithId:conversationID block:^(PFObject* _Nullable object, NSError* _Nullable error) {
        convoMessages = [NSMutableArray arrayWithArray:object[@"messages"]];
    }];
    
    return convoMessages;
}

+ (nonnull NSString* ) checkIfConversationExists: (PFUser* _Nullable )otherUser withCurrentUser: (PFUser* _Nullable )currentUser {
    
    NSString* otherUserID = otherUser.objectId;
    NSString* currentUserID = currentUser.objectId;
    
    // Create a query predicate where otherUser objectID is either found in the userOne or userTwo column of the Conversation database
    
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"%@ IN userTwo OR %@ IN userOne", otherUserID];
    
    PFQuery* findOtherUserQuery = [PFQuery queryWithClassName:@"Conversation" predicate:pred];
    
    // Using the query results, create another query where the PFUser Current User objectID is either found in the userOne or userTwo column of the Conversation database
    
    NSPredicate* predOther = [NSPredicate predicateWithFormat:@"%@ IN userTwo OR %@ IN userOne", currentUserID];
    
    PFQuery* findCurrentUserQuery = [PFQuery queryWithClassName:@"Conversation" predicate:predOther];
    
    PFQuery* finalQuery = [PFQuery orQueryWithSubqueries:@[findOtherUserQuery, findCurrentUserQuery]];
    
    __block Conversation* convo = [Conversation new];
    
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
            
            convo[@"userOneID"] = currentUserID;
            convo[@"userTwoID"] = otherUserID;
        }
    }];
    
    // If the final query is empty and does not have objects:
    // Create a new Conversation object where userOneID == PFUser Current User objectID. And userTwoID == otherUser objectID
    // Store that Conversation objectID and segue to Conversation View Controller

    return convo.objectId;
}
@end
