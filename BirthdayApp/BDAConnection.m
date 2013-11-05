//
//  BDAConnection.m
//  BirthdayApp
//
//  Created by ilteris on 10/31/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//

#import "BDAConnection.h"
#import "BDADataSource.h"

@implementation BDAConnection


+(void) loginFacebook:(id<BDAConnectionDelegate>)delegate;
{
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[@"user_about_me", @"user_relationships", @"friends_hometown",
                                  @"friends_birthday",@"friends_location", @"user_birthday", @"user_location"];
    
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
		// Was login successful ?
		if (!user) {
			if (!error) {
                NSLog(@"The user cancelled the Facebook login.");
            } else {
                NSLog(@"An error occurred: %@", error.localizedDescription);
            }
            
			// Callback - login failed
			if ([delegate respondsToSelector:@selector(facebookDidLogin:)]) {
				[delegate facebookDidLogin:NO];
			}
		} else {
			if (user.isNew) {
				NSLog(@"User signed up and logged in through Facebook!");
			} else {
				NSLog(@"User logged in through Facebook!");
			}
            
			// Callback - login successful
            if ([delegate respondsToSelector:@selector(facebookDidLogin:)]) {
                [delegate facebookDidLogin:YES];
            }
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {

            NSDictionary<FBGraphUser> *me = (NSDictionary<FBGraphUser> *)result;
            // Store the Facebook Id
            // NSLog(@"me is %@", me);
            
            
            [[PFUser currentUser] setObject:me.id forKey:@"fbId"];
            
            [[PFUser currentUser] saveInBackground];
            
            [[[BDADataSource sharedInstance] fbFriends] setObject:me forKey:me.id];
            
                }}];
            
		}
	}];
    
}


+(void) uploadUsersWithBirthdaysToParse:(id<BDAConnectionDelegate>)delegate
{
    
            // 1 Build a Facebook Request object to retrieve  friends from Facebook.
            
            FBRequest *friendRequest = [FBRequest requestForGraphPath:@"me/friends?fields=name,picture,birthday,location"];
            [ friendRequest startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary* result, NSError *error) {
                NSArray *friends = result[@"data"];
                NSLog(@"friends are %li", [friends count]);
                
                for (FBGraphObject<FBGraphUser> *aFriend in friends) {
                    NSLog(@"%@, %@", [aFriend birthday], [aFriend location]);
                  
                    
                    
                    // [[[BDADataSource sharedInstance] fbFriends] setObject:aFriend forKey:aFriend.id];
                   /*
                    PFObject *friend = [PFObject objectWithClassName:@"Friend"];
                    friend[@"userFBId"] = [[PFUser currentUser] objectForKey:@"fbId"];
                    friend[@"birthday"] = aFriend.birthday;
                    friend[@"name"] = aFriend.name;
                    
                    [friend save];
                    */
                }
                
            /*
                if ([delegate respondsToSelector:@selector(parseUploadComplete:)]) {
                    [delegate parseUploadComplete:YES];
                }

            */
                
            }];
}

@end
