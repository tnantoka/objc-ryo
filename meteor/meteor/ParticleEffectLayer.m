//
//  ParticleEffectLayer.m
//  meteor
//
//  Created by Miyake Ryo on 13/02/08.
//  Copyright (c) 2013年 Miyake Ryo. All rights reserved.
//

#import "ParticleEffectLayer.h"
#import <AudioToolbox/AudioServices.h>

@implementation ParticleEffectLayer{
    int _animationCount;
    SystemSoundID _soundId;
}

- (id)init
{
    if(self=[super init]){
        self.time = 1.0;
        self.tag = 0;
        _compleate = nil;
        _animationCount = 0;
        _soundId = 0;
    }
    return self;
}

- (void)dealloc
{
    if(_soundId!=0)
        AudioServicesDisposeSystemSoundID(_soundId);
    _soundId = 0;
}

- (void)go
{
    [self goAndComplete:nil];
}

- (void)goAndComplete:(ParticleEffectLayerHandler)complete
{
    _compleate = complete;
    [self _action];
    [self _sound];
}

- (void)_action
{
    //
}

- (void)_sound
{
    NSString *path = [self _soundPath];
    if(!path)
        return;
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &_soundId);
    AudioServicesPlaySystemSound(_soundId);
}

- (NSString*)_soundPath
{
    return nil;
}

//Animation完了
- (void)animationDidStop:(CAAnimation*)anim finished:(BOOL)flag
{
    _animationCount--;
    if(_animationCount>0)
        return;
    _animationCount = 0;
	if(_compleate)
        _compleate(self);
    _compleate = nil;
    [self removeFromSuperlayer];
}

- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key
{
    if([anim delegate]==self)
        _animationCount++;
    [super addAnimation:anim forKey:key];
}

//回転
- (void)rotateFrom:(CGFloat)from To:(CGFloat)to
{
	CABasicAnimation *anime = [CABasicAnimation animationWithKeyPath:@"transform"];
	CATransform3D trans3D;
    trans3D = CATransform3DMakeRotation(from, 0.0, 0.0, 1.0);
    anime.fromValue = [NSValue valueWithCATransform3D:trans3D];
    trans3D = CATransform3DMakeRotation(to, 0.0, 0.0, 1.0);
    anime.toValue = [NSValue valueWithCATransform3D:trans3D];
	anime.duration = self.time;
	anime.delegate = self;
	[self addAnimation:anime forKey:@"transform"];
	self.transform = trans3D;
}

//透明度
- (void)opacityFrom:(CGFloat)from To:(CGFloat)to
{
	CABasicAnimation *anime = [CABasicAnimation animationWithKeyPath:@"opacity"];
	anime.fromValue = [NSNumber numberWithFloat:from];
	anime.toValue = [NSNumber numberWithFloat:to];
	anime.delegate = self;
	anime.duration = self.time;
	[self addAnimation:anime forKey:@"opacity"];
	self.opacity = to;
}

//サイズ
- (void)scaleFrom:(CGFloat)from To:(CGFloat)to
{	
	CGRect fromR = CGRectMake(0, 0, self.bounds.size.width*from, self.bounds.size.height*from);
	CGRect toR = CGRectMake(0, 0, self.bounds.size.width*to, self.bounds.size.height*to);
	CABasicAnimation *anime = [CABasicAnimation animationWithKeyPath:@"bounds"];
	anime.fromValue = [NSValue valueWithCGRect:fromR];
	anime.toValue = [NSValue valueWithCGRect:toR];
	anime.duration = self.time;
	anime.delegate = self;
	[self addAnimation:anime forKey:@"bounds"];
	self.bounds = toR;
}

//ポジション
- (void)positionTo:(CGPoint)to
{
	CABasicAnimation *anime = [CABasicAnimation animationWithKeyPath:@"position"];
	CGPoint	fromPt = self.position;
	anime.duration = self.time;
	anime.fromValue = [NSValue valueWithCGPoint:fromPt];
	anime.toValue = [NSValue valueWithCGPoint:to];
	anime.delegate = self;
	[self addAnimation:anime forKey:@"position"];
	self.position = to;
}

@end
