//
//  BDAConnection.h
//  BirthdayApp
//
//  Created by ilteris on 10/31/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol BDAConnectionDelegate <NSObject>

@optional
+(void) facebookDidLogin:(BOOL)loggedIn;


@end




@interface BDAConnection : NSObject
+(void) loginFacebook:(id<BDAConnectionDelegate>)delegate;


@end
