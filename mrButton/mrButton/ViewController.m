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
    self.title = @"UIBarButtonItem";
    
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
    barButton.tintColor = [UIColor colorWithWhite:0.5 alpha:1];
    [barButton release];
    barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                                                              target:self 
                                                              action:@selector(buttonTap:)];
    barButton.tintColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.1 alpha:1];
    self.navigationItem.rightBarButtonItem = barButton;
    [barButton release];
    [naviBar pushNavigationItem:self.navigationItem animated:NO];
    
    
    //2段目
    UINavigationItem *naviItem = [[UINavigationItem alloc] initWithTitle:@"UIBarButtonItem"];
    navBarFrame.origin.y = 44.0;
    naviBar = [[[UINavigationBar alloc] initWithFrame:navBarFrame] autorelease];
    naviBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    naviBar.tintColor = [UIColor blackColor];
    [self.view addSubview:naviBar];
    
    barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                              target:self 
                                                              action:@selector(buttonTap:)];
    barButton.tintColor = [UIColor colorWithRed:0.8 green:0.08 blue:0.08 alpha:1];
    naviItem.leftBarButtonItem = barButton;
    [barButton release];
    
    barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                                                              target:self 
                                                              action:@selector(buttonTap:)];
    barButton.tintColor = [UIColor colorWithRed:0.2 green:0 blue:0.9 alpha:1];
    naviItem.rightBarButtonItem = barButton;
    [barButton release];
    [naviBar pushNavigationItem:naviItem animated:NO];
    
    
    //下半分を暗く
    CGSize size = frame.size;
    size.height -= navBarFrame.origin.x + navBarFrame.size.height;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectZero;
    rect.origin.y = navBarFrame.origin.x + navBarFrame.size.height;
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 95, frame.size.width, 30)];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"UIBarButtonItemっぽいボタン";
    [self.view addSubview:label];
    [label release];
    
    mrButton *button;
    button = [[mrButton alloc] initWithFrame:CGRectMake(10, 130, 55, 32)];
    button.title = @"OK";
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(70, 130, 60, 32)];
    button.title = @"Cancel";
    button.tintColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.1 alpha:1];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(135, 130, 55, 32)];
    button.title = @"Done";
    button.tintColor = [UIColor colorWithRed:0.8 green:0.08 blue:0.08 alpha:1];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(195, 130, 55, 32)];
    button.title = @"Edit";
    button.tintColor = [UIColor colorWithRed:0.2 green:0 blue:0.9 alpha:1];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    //普通のボタン
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, frame.size.width, 30)];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"普通のUIButton";
    [self.view addSubview:label];
    [label release];
    
    UIButton *btn;
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10, 220, 55, 32);
    [btn setTitle:@"OK" forState:0];
    btn.tintColor = [UIColor colorWithWhite:0.5 alpha:1];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(70, 220, 60, 32);
    [btn setTitle:@"Cancel" forState:0];
    btn.tintColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.1 alpha:1];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(135, 220, 55, 32);
    [btn setTitle:@"Done" forState:0];
    btn.tintColor = [UIColor colorWithRed:0.8 green:0.08 blue:0.08 alpha:1];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(195, 220, 55, 32);
    [btn setTitle:@"Edit" forState:0];
    [self.view addSubview:btn];
    
    //下の段
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 285, frame.size.width, 30)];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"UIBarButtonItemっぽいボタン";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    [label release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(10, 320, 55, 32)];
    button.title = @"OK";
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(70, 320, 60, 32)];
    button.title = @"Cancel";
    button.tintColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.1 alpha:1];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(135, 320, 55, 32)];
    button.title = @"Done";
    button.tintColor = [UIColor colorWithRed:0.8 green:0.08 blue:0.08 alpha:1];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    button = [[mrButton alloc] initWithFrame:CGRectMake(195, 320, 55, 32)];
    button.title = @"Edit";
    button.tintColor = [UIColor colorWithRed:0.2 green:0 blue:0.9 alpha:1];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 370, frame.size.width, 30)];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"普通のUIButton";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    [label release];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10, 410, 55, 32);
    [btn setTitle:@"OK" forState:0];
    btn.tintColor = [UIColor colorWithWhite:0.5 alpha:1];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(70, 410, 60, 32);
    [btn setTitle:@"Cancel" forState:0];
    btn.tintColor = [UIColor colorWithRed:0.2 green:0.6 blue:0.1 alpha:1];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(135, 410, 55, 32);
    [btn setTitle:@"Done" forState:0];
    btn.tintColor = [UIColor colorWithRed:0.8 green:0.08 blue:0.08 alpha:1];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(195, 410, 55, 32);
    [btn setTitle:@"Edit" forState:0];
    [self.view addSubview:btn];
    
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
