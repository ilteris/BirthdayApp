//
//  BDADataSource.m
//  BirthdayApp
//
//  Created by ilteris on 10/31/13.
//  Copyright (c) 2013 ilteris. All rights reserved.
//

#import "BDADataSource.h"

@implementation BDADataSource

NSMutableArray* _birthdayOfFriends;

+(id)sharedInstance {
    static dispatch_once_t p = 0;
    
    __strong static id _sharedObject = nil;
    
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}


-(id)init {
    self =[super init];
    if (self) {
        //initialize Default Data here.
        [self initializeDefaultDataList];
    }
    return self;
}

-(void)initializeDefaultDataList {
    _fbFriends = [[NSMutableDictionary alloc] init];
    _birthdayOfFriends = [[NSMutableArray alloc] init];
    
}

-(void)reset {
    [_fbFriends removeAllObjects];
    [_birthdayOfFriends removeAllObjects];
}

@end
