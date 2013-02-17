//
//  RecoveryEffectLayer.m
//  meteor
//
//  Created by Miyake Ryo on 13/02/09.
//  Copyright (c) 2013年 Miyake Ryo. All rights reserved.
//

#import "RecoveryEffectLayer.h"

@implementation RecoveryEffectLayer

- (void)_action
{
    self.frame = CGRectMake(0, 0, 200, 200);
    self.position = self.location;
    self.contents = (id)[[UIImage imageNamed:self.tag%2==0 ? @"Recovery_1.png" : @"Recovery_2.png"] CGImage];
    
    //拡大
    [self scaleFrom:0.0 To:IPAD ? 2.0 : 1.5];
    //透明
    CAKeyframeAnimation *opacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacity.values = @[@0.0, @1.0, @0.0];
    opacity.duration = self.time;
    opacity.keyTimes = @[@0.00, @0.50, @1.00];
    [self addAnimation:opacity forKey:@"opacity"];
    self.opacity = 0;
}
/*
- (NSString*)_soundPath
{
    return [[NSBundle mainBundle] pathForResource:@"rpg2" ofType:@"mp3"];
}
*/
@end
