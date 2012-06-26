//
//  mrLock.m
//  mrlock
//
//  Created by ryo on 12/06/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "mrLock.h"

@implementation mrLock

- (id)init
{
    self = [super init];
    _subLockedCount = 0;
    _mainLocked = NO;
    return self;
}

- (void)mainLock
{
    _mainLocked = YES;
    while(_subLockedCount>0){
        [NSThread sleepForTimeInterval:0.1];
    }
    [self lock];
}

- (void)mainUnlock
{
    [self unlock];
    _mainLocked = NO;
}

- (void)subLock
{
    while(_mainLocked){
        [NSThread sleepForTimeInterval:0.1];
    }
    _subLockedCount++;
}

- (void)subUnlock
{
    _subLockedCount--;
}

@end
