//
//  DodoEffectLayer.m
//  meteor
//
//  Created by Miyake Ryo on 13/02/15.
//  Copyright (c) 2013年 Miyake Ryo. All rights reserved.
//

#import "DodoEffectLayer.h"

@implementation DodoEffectLayer

- (id)init
{
    if(self=[super init]){
        self.time = 1.0;
        self.text = @"ドドドドドドドッ!!";
    }
    return self;
}

- (void)_action
{
    if(!(self.tag < [self.text length])){
        [self animationDidStop:nil finished:YES];
        return;
    }
 
    NSString *c = [self.text substringWithRange:NSMakeRange(self.tag, 1)];
    CGSize size = [c sizeWithFont:[UIFont boldSystemFontOfSize:100]];
    CGRect rect = CGRectZero;
    rect.size = size;
    self.frame = rect;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [[UIColor whiteColor] set];
    [c drawAtPoint:CGPointZero
          withFont:[UIFont boldSystemFontOfSize:100]];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.contents = (id)newImage.CGImage;
    
    CGPoint from = self.center;
    CGPoint to = self.location;
    from.x += 400;
    from.y += 200;
    to.x -= 300;
    to.y -= 100;
    self.position = from;
    [self scaleFrom:0.05 To:3.0];
    
    [self positionTo:to];
}

@end
