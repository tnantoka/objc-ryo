//
//  ViewController.m
//  mrButton
//
//  Created by ryo on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "mrButton.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    self.view = [[[UIView alloc] initWithFrame:frame] autorelease];
    
    //普通の UIBarButtonItem
    CGRect navBarFrame = self.view.bounds;
    navBarFrame.size.height = 44.0;
    UINavigationBar *naviBar = [[[UINavigationBar alloc] initWithFrame:navBarFrame] autorelease];
    naviBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:naviBar];
    
    UIBarButtonItem *barButton;
    barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                              target:self 
                                                              action:@selector(buttonTap:)];
    self.navigationItem.leftBarButtonItem = barButton;
    [barButton release];
    barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                                                              target:self 
                                                              action:@selector(buttonTap:)];
    barButton.tintColor = [UIColor colorWithWhite:0.4 alpha:1];
    self.navigationItem.rightBarButtonItem = barButton;
    [barButton release];
    [naviBar pushNavigationItem:self.navigationItem animated:NO];
    
    
    //下半分を暗く
    CGSize size = frame.size;
    size.height -= navBarFrame.size.height;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectZero;
    rect.size = size;
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextFillRect(context, rect);
    rect.size.height = rect.size.height/2;
    rect.origin.y += rect.size.height;
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.8);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.layer.contents = (id)img.CGImage;
    
    
    //UIBarButtonItem っぽいボタン
    mrButton *button;
    button = [[mrButton alloc] initWithFrame:CGRectMake(10, 60, 55, 32)];
    button.title = @"OK";
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(70, 60, 60, 32)];
    button.title = @"Cancel";
    button.tintColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.1 alpha:1];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(135, 60, 55, 32)];
    button.title = @"Done";
    button.tintColor = [UIColor colorWithRed:0.8 green:0.08 blue:0.08 alpha:1];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(195, 60, 55, 32)];
    button.title = @"Edit";
    button.tintColor = [UIColor colorWithRed:0.2 green:0 blue:0.9 alpha:1];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(10, 240, 55, 32)];
    button.title = @"OK";
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(70, 240, 60, 32)];
    button.title = @"Cancel";
    button.tintColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.1 alpha:1];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(135, 240, 55, 32)];
    button.title = @"Done";
    button.tintColor = [UIColor colorWithRed:0.8 green:0.08 blue:0.08 alpha:1];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(195, 240, 55, 32)];
    button.title = @"Edit";
    button.tintColor = [UIColor colorWithRed:0.2 green:0 blue:0.9 alpha:1];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    return self;
}

- (void)buttonTap:(UIView*)button
{
    NSLog(@"buttonTap: %@", [(id)button title]);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
