//
//  KitaEffectLayer.m
//  meteor
//
//  Created by Miyake Ryo on 13/02/15.
//  Copyright (c) 2013年 Miyake Ryo. All rights reserved.
//

#import "KitaEffectLayer.h"

@implementation KitaEffectLayer

static float _kita_y = 0;

- (id)init
{
    if(self=[super init]){
        self.time = 2.0;
        self.text = @"キターーーーーーー!!";
    }
    return self;
}

- (void)_action
{
    NSString *__text = self.text;
    CGFloat actualFontSize;
    CGSize size = [__text sizeWithFont:[UIFont boldSystemFontOfSize:80]
                           minFontSize:50
                        actualFontSize:&actualFontSize
                              forWidth:self.superlayer.frame.size.width*1.5
                         lineBreakMode:NSLineBreakByTruncatingTail];
    CGRect rect = CGRectZero;
    rect.size = size;
    
    CGPoint from = CGPointZero;
    from.x = self.superlayer.frame.size.width*1.5;
    from.x += size.width;
    from.y = rand()%(int)(self.superlayer.frame.size.height*0.3*1) + 40;
    if(abs(from.y-_kita_y) < size.height){
        from.y = (from.y<(self.superlayer.frame.size.height/2)) ? (_kita_y + size.height*2) : (_kita_y - size.height*2);
    }
    _kita_y = from.y;
    self.frame = rect;
    self.position = from;
    
    CGPoint to = from;
    to.x = 0;
    to.x -= size.width;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [[UIColor whiteColor] set];
    [__text drawAtPoint:CGPointZero
               forWidth:size.width
               withFont:[UIFont boldSystemFontOfSize:actualFontSize]
          lineBreakMode:NSLineBreakByTruncatingTail];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.contents = (id)newImage.CGImage;
    
    //移動
    [self positionTo:to];
}

@end
