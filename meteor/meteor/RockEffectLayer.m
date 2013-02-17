//
//  RockEffectLayer.m
//  meteor
//
//  Created by Miyake Ryo on 13/02/08.
//  Copyright (c) 2013年 Miyake Ryo. All rights reserved.
//

#import "RockEffectLayer.h"

@implementation RockEffectLayer

- (id)init
{
    if(self=[super init]){
        self.time = 1.2;
    }
    return self;
}

- (void)_action
{
    self.frame = CGRectMake(0, 0, 200, 200);
    self.position = self.location;
    self.contents = (id)[[UIImage imageNamed:@"rock.png"] CGImage];
    //移動
    [self positionTo:self.to];
    //回転
    int d = rand()%120;
    [self rotateFrom:M_PI/180*d To:M_PI/180*(90+d)];
    //縮小
    [self scaleFrom:2.0 To:0.0];
}

- (NSString*)_soundPath
{
    return [[NSBundle mainBundle] pathForResource:@"rpg2" ofType:@"mp3"];
}

@end
