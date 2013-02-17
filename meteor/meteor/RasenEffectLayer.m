//
//  RasenEffectLayer.m
//  meteor
//
//  Created by Miyake Ryo on 13/02/15.
//  Copyright (c) 2013年 Miyake Ryo. All rights reserved.
//

#import "RasenEffectLayer.h"

@implementation RasenEffectLayer

- (id)init
{
    if(self=[super init]){
        self.time = 5.0;
        self.text = @"俺の話を聞け";
    }
    return self;
}

- (void)_action
{
    CGSize size = [self.text sizeWithFont:[UIFont boldSystemFontOfSize:40] forWidth:300 lineBreakMode:NSLineBreakByClipping];
    CGRect rect = CGRectZero;
    size.width *= 3;
    rect.size = size;
    self.frame = rect;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [[UIColor whiteColor] set];
    [self.text drawAtPoint:CGPointZero
                  forWidth:300
                  withFont:[UIFont boldSystemFontOfSize:40]
             lineBreakMode:NSLineBreakByClipping];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.contents = (id)newImage.CGImage;
    
    
    CGPoint from = self.center;
    CGPoint to = self.center;
    from.y -= 400;
    to.y += 200;
    self.position = from;
    [self positionTo:to];
    
    CAKeyframeAnimation *transform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D trans3D = CATransform3DMakeRotation(0, 0.0, 1.0, 0.0);
    CATransform3D trans3D2 = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
    transform.values = @[[NSValue valueWithCATransform3D:trans3D], [NSValue valueWithCATransform3D:trans3D2], [NSValue valueWithCATransform3D:trans3D]];
    transform.duration = self.time/3;
    transform.repeatCount = 3;
    //transform.keyTimes = @[@0.00, @0.70, @0.80, @1.00];
    [self addAnimation:transform forKey:@"transform"];
    
	self.transform = trans3D;
}

@end
