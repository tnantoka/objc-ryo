//
//  mrButton.m
//  mrButton
//
//  Created by ryo on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "mrButton.h"
#import "UIColor+mrButton.h"

@implementation mrButton
@synthesize tintColor;

+ (id)buttonWithType:(UIButtonType)buttonType
{
    //Typeとかは無視する
    return [[[[self class] alloc] init] autorelease];
}

+ (id)buttonWithFrame:(CGRect)frame
{
    return [[[[self class] alloc] initWithFrame:frame] autorelease];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        CGRect titleFrame = self.bounds;
        titleFrame.origin.x += 3;
        titleFrame.size.width -= 6;
        titleFrame.size.height -= 2;
        _titleLabel = [[[UILabel alloc] initWithFrame:titleFrame] autorelease];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.lineBreakMode = UILineBreakModeMiddleTruncation;
        _titleLabel.shadowOffset = CGSizeMake(0, -1);
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLabel];
        self.tintColor = [UIColor colorWithRed:0.126 green:0.134 blue:0.152 alpha:1];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect titleFrame = self.bounds;
    titleFrame.origin.x += 3;
    titleFrame.size.width -= 6;
    titleFrame.size.height -= 2;
    _titleLabel.frame = titleFrame;
}

- (void)dealloc
{
    [tintColor release];
    tintColor = nil;
    [super dealloc];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [self setTitle:title];
}
- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}
- (NSString*)title
{
    return _titleLabel.text;
}

- (void)setFont:(UIFont*)font
{
    _titleLabel.font = font;
}
- (UIFont*)font
{
    return _titleLabel.font;
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    switch (state) {
        case UIControlStateNormal:
            _titleLabel.textColor = color;
            break;
        default:
            break;
    }
}
- (void)setTitleShadowColor:(UIColor *)color forState:(UIControlState)state
{
    switch (state) {
        case UIControlStateNormal:
            _titleLabel.shadowColor = color;
            break;
        default:
            break;
    }
}
- (void)setHighlighted:(BOOL)highlighted
{
    if(self.highlighted!=highlighted)
        [self setNeedsDisplay];
    [super setHighlighted:highlighted];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    _titleLabel.enabled = enabled;
}

- (void)roundRectPath:(CGRect)rect radius:(CGFloat)rad context:(CGContextRef)context
{	
    CGFloat lx = CGRectGetMinX(rect);
    CGFloat rx = CGRectGetMaxX(rect);
    CGFloat ty = CGRectGetMinY(rect);
    CGFloat by = CGRectGetMaxY(rect);
	
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, lx+rad, by);    
    CGContextAddArcToPoint(context, lx, by, lx, by-rad, rad);
    CGContextAddLineToPoint(context, lx, ty+rad);
    CGContextAddArcToPoint(context, lx, ty, lx+rad, ty, rad);
    CGContextAddLineToPoint(context, rx-rad, ty);
    CGContextAddArcToPoint(context, rx, ty, rx, ty+rad, rad);
    CGContextAddLineToPoint(context, rx, by-rad);
    CGContextAddArcToPoint(context, rx, by, rx-rad, by, rad);
}

- (void)drawRect:(CGRect)rect
{
    CGRect rect2 = rect;
    rect2.origin.x += 1;
    rect2.origin.y += 1;
    rect2.size.width -= 2;
    rect2.size.height -= 3;
    
    CGContextRef context = UIGraphicsGetCurrentContext(); 
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGFloat rad = 5.0;
    //RGBAを分解
    CGFloat tiRed, tiGreen, tiBlue, tiHue, tiSat, tiBri;
    [self.tintColor red:&tiRed green:&tiGreen blue:&tiBlue alpha:nil hue:&tiHue saturation:&tiSat brightness:&tiBri];
    //ちょっと暗めの色を作る
    if(self.highlighted){
        UIColor *highlightedColor = [UIColor colorWithHue:tiHue saturation:tiSat brightness:MAX(tiBri-0.1, 0) alpha:1];
        [highlightedColor red:&tiRed green:&tiGreen blue:&tiBlue alpha:nil hue:&tiHue saturation:&tiSat brightness:&tiBri];
    }else if(!self.enabled){
        UIColor *disabledColor = [UIColor colorWithHue:tiHue saturation:MAX(tiSat-0.3, 0) brightness:MAX(tiBri-0.4, 0) alpha:1];
        [disabledColor red:&tiRed green:&tiGreen blue:&tiBlue alpha:nil hue:&tiHue saturation:&tiSat brightness:&tiBri];
    }
    
    //白で薄くぬる
    CGRect rect3 = rect2;
    rect3.size.height += 1;
    CGContextSaveGState(context);
    [self roundRectPath:rect3 radius:rad context:context];
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextSetRGBFillColor(context, 1, 1, 1, 0.3);
    CGContextFillRect(context, rect3);
    CGContextRestoreGState(context);
    
    //背景色
    CGContextSaveGState(context);
    [self roundRectPath:rect2 radius:rad context:context];
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextSetRGBFillColor(context, tiRed, tiGreen, tiBlue, 1.0);
    CGContextFillRect(context, rect2);
    
    //白のグラデーション
    CGFloat components[] = {
        1.0, 1.0, 1.0, 0.4,
        1.0, 1.0, 1.0, 0.0
    };
    CGFloat locations[] = {0.0, 0.6};
    if(self.highlighted)
        locations[1] = 0.7;
    size_t count = sizeof(components) / (sizeof(CGFloat)* 4);
    CGPoint startPoint = rect2.origin;
    CGPoint endPoint = rect2.origin;
    endPoint.y += rect2.size.height;
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef, components, locations, count);
    CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradientRef);
    CGContextRestoreGState(context);
    
    //枠
    UIColor *frameColor = [UIColor colorWithHue:tiHue saturation:tiSat brightness:MAX(tiBri-0.1, 0) alpha:1];
    [frameColor red:&tiRed green:&tiGreen blue:&tiBlue alpha:nil];
    [self roundRectPath:rect2 radius:rad context:context];
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBStrokeColor(context, tiRed, tiGreen, tiBlue, 0.9);
    CGContextStrokePath(context);
    //枠の下は薄めに
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(rect2)+rad, CGRectGetMaxY(rect2));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect2)-rad, CGRectGetMaxY(rect2));
    CGContextSetRGBStrokeColor(context, tiRed, tiGreen, tiBlue, 0.7);
    CGContextStrokePath(context);
    //枠の上だけ濃くする
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(rect2)+rad, CGRectGetMinY(rect2));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect2)-rad, CGRectGetMinY(rect2));
    CGContextSetLineWidth(context, 0.5);
    CGContextSetRGBStrokeColor(context, tiRed, tiGreen, tiBlue, 0.9);
    CGContextStrokePath(context);
    
    CGColorSpaceRelease(colorSpaceRef);
}

@end
