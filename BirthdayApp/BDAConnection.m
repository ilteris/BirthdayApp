//
//  BDAConnection.m
//  BirthdayApp
//
//  Created by ilteris on 10/31/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//

#import "BDAConnection.h"
#import <Parse/Parse.h>
#import "BDADataSource.h"

@implementation BDAConnection


+(void) loginFacebook:(id<BDAConnectionDelegate>)delegate;
{
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
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
			[FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    NSDictionary<FBGraphUser> *me = (NSDictionary<FBGraphUser> *)result;
                    // Store the Facebook Id
                    NSLog(@"me is %@", me);
                    
                    [[PFUser currentUser] setObject:me.id forKey:@"fbId"];
                    
                    [[PFUser currentUser] saveInBackground];
                    
                    [[[BDADataSource sharedInstance] fbFriends] setObject:me forKey:me.id];

                    
                    // 1 Build a Facebook Request object to retrieve  friends from Facebook.
                    FBRequest *friendsRequest = [FBRequest requestForMyFriends];
                    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                                  NSDictionary* result,
                                                                  NSError *error) {
                        // 2 Loop through the array of FBGraphUser objects data returned from the Facebook request.
                        NSArray *friends = result[@"data"];
                        for (NSDictionary<FBGraphUser>* friend in friends) {
                            NSLog(@"Found a friend: %@", friend.name);
                            
                            // Add each friend’s FBGraphUser object to the friends list in the DataStore
                            [[[BDADataSource sharedInstance] fbFriends] setObject:friend forKey:friend.id];
                        }
                        
                        
                       
                        // The success callback to the delegate is now only called once the friends request has been made.
                        if ([delegate respondsToSelector:@selector(facebookDidLogin:)]) {
                            [delegate facebookDidLogin:YES];
                        }
                    }];
                    
                    
                }
                
                
            }];
		}
	}];
    
}
@end
