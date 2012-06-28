//
//  UIColor+mrButton.m
//  mrButton
//
//  Created by ryo on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIColor+mrButton.h"

#if !defined(MIN3)
#define MIN3(A,B,C)	({ __typeof__(A) __a = (A); __typeof__(B) __b = (B);  __typeof__(C) __c = (C); __a < __b ? (__a < __c ? __a : __c) : (__b < __c ? __b : __c); })
#endif

#if !defined(MAX3)
#define MAX3(A,B,C)	({ __typeof__(A) __a = (A); __typeof__(B) __b = (B);  __typeof__(C) __c = (C); __a < __b ? (__b < __c ? __c : __b) : (__a < __c ? __c : __a); })
#endif

@implementation UIColor (mrButton)

- (void)red:(CGFloat*)red green:(CGFloat*)green blue:(CGFloat*)blue alpha:(CGFloat*)alpha
{
    const CGFloat *rgba = CGColorGetComponents(self.CGColor);
    int rgbaCount = CGColorGetNumberOfComponents(self.CGColor);
    if(red!=nil)
        *red = rgba[0];
    if(green!=nil)
        *green = rgba[(rgbaCount == 4 ? 1 : 0)];
    if(blue!=nil)
        *blue = rgba[(rgbaCount == 4 ? 2 : 0)];
    if(alpha!=nil)
        *alpha = rgba[(rgbaCount == 4 ? 3 : 1)];
}

- (void)hue:(CGFloat*)hue saturation:(CGFloat*)saturation brightness:(CGFloat*)brightness
{
    [self red:nil green:nil blue:nil alpha:nil hue:hue saturation:saturation brightness:brightness]; 
}

- (void)red:(CGFloat*)red green:(CGFloat*)green blue:(CGFloat*)blue alpha:(CGFloat*)alpha
        hue:(CGFloat*)hue saturation:(CGFloat*)saturation brightness:(CGFloat*)brightness
{
    CGFloat r, g, b, a;
    [self red:&r green:&g blue:&b alpha:&a];
    if(red!=nil)
        *red = r;
    if(green!=nil)
        *green = g;
    if(blue!=nil)
        *blue = b;
    if(alpha!=nil)
        *alpha = a;
    
    CGFloat max = MAX3(r, g, b);
    CGFloat min = MIN3(r, g, b);
    
    if(hue!=nil){
        if (g == max)
            *hue = (b - r) / ( max - min ) * 60 + 120;
        else if (b == max)
            *hue = (r - g) / ( max - min ) * 60 + 240;
        else if (g < b)
            *hue = (g - b) / ( max - min ) * 60 + 360;
        else
            *hue = (g - b) / ( max - min ) * 60;
        *hue = *hue / 360;
    }
    if(saturation!=nil)
        *saturation = ( max - min ) / max;
    if(brightness!=nil)
        *brightness = max;
}

+ (CGFloat)hueFromRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b
{
    CGFloat max = MAX3(r, g, b);
    CGFloat min = MIN3(r, g, b);
    CGFloat hue;
    if (g == max)
        hue = (b - r) / ( max - min ) * 60 + 120;
    else if (b == max)
        hue = (r - g) / ( max - min ) * 60 + 240;
    else if (g < b)
        hue = (g - b) / ( max - min ) * 60 + 360;
    else
        hue = (g - b) / ( max - min ) * 60;
    return hue / 360;
}

+ (CGFloat)saturationFromRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b
{
    CGFloat max = MAX3(r, g, b);
    CGFloat min = MIN3(r, g, b);
    return ( max - min ) / max;
}

+ (CGFloat)brightnessFromRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b
{
    return MAX3(r, g, b);
}

+ (CGFloat)luminanceFromRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b
{
    return ( 0.298912 * r + 0.586611 * g + 0.114478 * b );
}

@end
