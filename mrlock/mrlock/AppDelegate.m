//
//  AppDelegate.m
//  mrlock
//
//  Created by ryo on 12/06/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "mrLock.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self test];
    return YES;
}

static mrLock *lock = nil;

- (void)test
{
    lock = [[mrLock alloc] init];
    [self performSelectorInBackground:@selector(main) withObject:nil];
    [self performSelectorInBackground:@selector(sub1) withObject:nil];
    [self performSelectorInBackground:@selector(sub2) withObject:nil];
}

- (void)main
{
    sleep(2);
    NSLog(@"*** main1 lock");
    [lock mainLock];
    @try{
        NSLog(@"******************** main1 do");
        sleep(5);
    }@finally {
        [lock mainUnlock];
        NSLog(@"******************** main1 unlock");
    }
    
    sleep(1);
    
    NSLog(@"*** main2 lock");
    [lock mainLock];
    @try{
        NSLog(@"******************** main2 do");
        sleep(5);
    }@finally {
        [lock mainUnlock];
        NSLog(@"******************** main2 unlock");
    }
}

- (void)sub1
{
    NSLog(@"---  sub1 lock");
    [lock subLock];
    @try{
        NSLog(@"--------------------  sub1 do");
        sleep(5);
    }@finally {
        [lock subUnlock];
        NSLog(@"--------------------  sub1 unlock");
    }
    
    sleep(3);
    
    NSLog(@"^^^  sub3 lock");
    [lock subLock];
    @try{
        NSLog(@"^^^^^^^^^^^^^^^^^^^^  sub3 do");
        sleep(5);
    }@finally {
        [lock subUnlock];
        NSLog(@"^^^^^^^^^^^^^^^^^^^^  sub3 unlock");
    }
}

- (void)sub2
{
    sleep(1);
    NSLog(@"...  sub2 lock");
    [lock subLock];
    @try{
        NSLog(@"....................  sub2 do");
        sleep(5);
    }@finally {
        [lock subUnlock];
        NSLog(@"....................  sub2 unlock");
    }
    
    sleep(8);
    
    NSLog(@":::  sub4 lock");
    [lock subLock];
    @try{
        NSLog(@"::::::::::::::::::::  sub4 do");
        sleep(5);
    }@finally {
        [lock subUnlock];
        NSLog(@"::::::::::::::::::::  sub4 unlock");
    }
}

@end
