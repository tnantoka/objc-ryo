//
//  ParticleEffectLayerFactory.m
//  meteor
//
//  Created by Miyake Ryo on 13/02/08.
//  Copyright (c) 2013年 Miyake Ryo. All rights reserved.
//

#import "ParticleEffectLayerFactory.h"

@implementation ParticleEffectLayerFactory

+ (id)createParticleEffectLayerFromType:(ParticleEffectType)type
{
    ParticleEffectLayer *layer = nil;
    switch (type) {
        case peBom:
            layer = [BomEffectLayer layer];
            break;
        case peRock:
        case peMeteor:
            layer = [RockEffectLayer layer];
            break;
        case peRecovery:
            layer = [RecoveryEffectLayer layer];
            break;
        case peKita:
            layer = [KitaEffectLayer layer];
            break;
        case peDodo:
            layer = [DodoEffectLayer layer];
            break;
        case peRasen:
            layer = [RasenEffectLayer layer];
            break;
        case peTitle:
            layer = [TitleEffectLayer layer];
            break;
        default:
            break;
    }
    return layer;
}

@end
