//
//  ParticleEffectLayerFactory.h
//  meteor
//
//  Created by Miyake Ryo on 13/02/08.
//  Copyright (c) 2013年 Miyake Ryo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParticleEffectLayer.h"
#import "RockEffectLayer.h"
#import "BomEffectLayer.h"
#import "RecoveryEffectLayer.h"
#import "KitaEffectLayer.h"
#import "DodoEffectLayer.h"
#import "RasenEffectLayer.h"
#import "TitleEffectLayer.h"

typedef enum {
	peBom = 0,    //爆発
	peRock = 1,   //隕石
    peMeteor = 2, //メテオ
    peRecovery = 3, //回復
    peKita = 4,
    peDodo = 5,
    peRasen = 6,
    peTitle = 7,
} ParticleEffectType;

@interface ParticleEffectLayerFactory : NSObject
+ (id)createParticleEffectLayerFromType:(ParticleEffectType)type;
@end
