//
//  BDADataSource.h
//  BirthdayApp
//
//  Created by ilteris on 10/31/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDADataSource : NSObject

@property (nonatomic, copy) NSMutableDictionary* fbFriends;


+ (id)sharedInstance;
-(void)reset;

@end
