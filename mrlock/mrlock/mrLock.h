//
//  mrLock.h
//  mrlock
//
//  Created by ryo on 12/06/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


@interface mrLock : NSLock{
    BOOL _mainLocked;
    int _subLockedCount;
}

- (void)mainLock;
- (void)mainUnlock;
- (void)subLock;
- (void)subUnlock;

@end
