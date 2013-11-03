//
//  BDABirthdayModel.h
//  BirthdayApp
//
//  Created by ilteris on 11/3/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//  Each user have n numbers of friends who are BirthdayUser

#import <Foundation/Foundation.h>

@interface BDABirthdayUser : NSObject
@property (nonatomic, strong) NSDictionary<FBGraphUser> *user;
@property (nonatomic, strong) id objectId;
@property (nonatomic, strong) NSDate *createdDate;

@end
