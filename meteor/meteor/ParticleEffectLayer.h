//
//  ParticleEffectLayer.h
//  meteor
//
//  Created by Miyake Ryo on 13/02/08.
//  Copyright (c) 2013年 Miyake Ryo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class ParticleEffectLayer;

typedef void(^ParticleEffectLayerHandler)(ParticleEffectLayer *layer);

@interface ParticleEffectLayer : CALayer{
    ParticleEffectLayerHandler _compleate;
}

@property (nonatomic, assign) double time;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign) int tag;

- (void)go;
- (void)goAndComplete:(ParticleEffectLayerHandler)complete;

- (void)rotateFrom:(CGFloat)from To:(CGFloat)to;
- (void)opacityFrom:(CGFloat)from To:(CGFloat)to;
- (void)scaleFrom:(CGFloat)from To:(CGFloat)to;
- (void)positionTo:(CGPoint)to;

@end
