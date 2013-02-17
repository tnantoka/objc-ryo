//
//  TitleEffectLayer.m
//  meteor
//
//  Created by Miyake Ryo on 13/02/16.
//  Copyright (c) 2013年 Miyake Ryo. All rights reserved.
//

#import "TitleEffectLayer.h"

@implementation TitleEffectLayer

- (id)init
{
    if(self=[super init]){
        self.time = 1.0;
        self.text = @"『メテオ』を作ってたら\nアニメーションが面白くなって\nいろいろ触ってみたよ";
    }
    return self;
}

- (void)_action
{
    CGSize size = [self.text sizeWithFont:[UIFont boldSystemFontOfSize:40]
                        constrainedToSize:CGSizeMake(600,500)
                            lineBreakMode:NSLineBreakByCharWrapping];
    CGRect rect = CGRectZero;
    rect.size = size;
    self.frame = rect;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [[UIColor whiteColor] set];
    [self.text drawInRect:rect
                 withFont:[UIFont boldSystemFontOfSize:40]
            lineBreakMode:NSLineBreakByCharWrapping
                alignment:NSTextAlignmentCenter];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.contents = (id)newImage.CGImage;
    
    CGPoint to = self.location;
    to.y -= 50;
    CGPoint from = to;
    from.y -= 200;
    self.position = from;
    [self scaleFrom:0.1 To:1.5];
    [self positionTo:to];
}
@end
