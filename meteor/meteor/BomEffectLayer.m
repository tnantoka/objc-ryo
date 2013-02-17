//
//  BomEffectLayer.m
//  meteor
//
//  Created by Miyake Ryo on 13/02/08.
//  Copyright (c) 2013年 Miyake Ryo. All rights reserved.
//

#import "BomEffectLayer.h"

@implementation BomEffectLayer

- (id)init
{
    if(self=[super init]){
        self.time = 1.6;
    }
    return self;
}

- (void)_action
{
    self.frame = CGRectMake(0, 0, 100, 100);
    self.position = self.location;
    
    NSArray *values;
    
    static NSValue*(^_3DVal)(float a,float b,float c) = ^(float a,float b,float c)
    {
        return [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, a, b, c)];
    };
    //スケール
    values = @[
              _3DVal(0.10, 0.10, 1.0),
              _3DVal(1.00, 1.00, 1.0),
              _3DVal(1.30, 1.30, 1.0),
              _3DVal(1.40, 1.40, 1.0),
              _3DVal(1.50, 1.50, 1.0),
              _3DVal(1.60, 1.60, 1.0),
              _3DVal(1.70, 1.70, 1.0),
              _3DVal(1.80, 1.80, 1.0),
              ];
    CAKeyframeAnimation *transform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transform.values = values;
    transform.duration = self.time;
    [self addAnimation:transform forKey:@"transform"];
    CATransform3D trans3D = [[values lastObject] CATransform3DValue];
    self.transform = trans3D;
    
    //透明
    CAKeyframeAnimation *opacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacity.values = @[@1.00, @0.95, @0.80, @0.00];
    opacity.duration = self.time;
    opacity.keyTimes = @[@0.00, @0.70, @0.80, @1.00];
    [self addAnimation:opacity forKey:@"opacity"];
    self.opacity = 0;
    
    //画像
    values = @[
              (id)[[UIImage imageNamed:@"bom.png"] CGImage],
              (id)[[UIImage imageNamed:@"smoke.png"] CGImage],
              ];
    CAKeyframeAnimation *contents = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    contents.values = values;
    contents.duration = self.time;
    contents.delegate = self;
    contents.keyTimes = @[@0.0, @0.7];
    [self addAnimation:contents forKey:@"contents"];
    self.contents = [values lastObject];
}

- (NSString*)_soundPath
{
    return [[NSBundle mainBundle] pathForResource:@"bom2" ofType:@"mp3"];
}

@end
