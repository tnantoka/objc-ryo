//
//  UIColor+mrButton.h
//  mrButton
//
//  Created by ryo on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (mrButton)

- (void)red:(CGFloat*)red green:(CGFloat*)green blue:(CGFloat*)blue alpha:(CGFloat*)alpha;
- (void)hue:(CGFloat*)hue saturation:(CGFloat*)saturation brightness:(CGFloat*)brightness;
- (void)red:(CGFloat*)red green:(CGFloat*)green blue:(CGFloat*)blue alpha:(CGFloat*)alpha
        hue:(CGFloat*)hue saturation:(CGFloat*)saturation brightness:(CGFloat*)brightness;
+ (CGFloat)hueFromRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b;
+ (CGFloat)saturationFromRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b;
+ (CGFloat)brightnessFromRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b;

@end
