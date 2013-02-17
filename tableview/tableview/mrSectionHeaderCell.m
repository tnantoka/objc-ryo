//
//  mrCell.m
//  tableview
//
//  Created by ryo on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "mrSectionHeaderCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation mrSectionHeaderCell
@synthesize ctrl;
@synthesize extended;
@synthesize savedRect;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
        self.textLabel.backgroundColor = [UIColor clearColor];
        ctrl = [[UIControl alloc] initWithFrame:self.bounds];
        ctrl.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        ctrl.backgroundColor = [UIColor clearColor];
        [self addSubview:ctrl];
        [ctrl release];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //背景
    CGFloat components[] = {
        0.35, 0.37, 0.46, 0.7,
        0.25, 0.28, 0.31, 0.7
    };
    CGFloat locations[] = {0.0, 1.0};
    size_t count = sizeof(components) / (sizeof(CGFloat)* 4);
    CGPoint startPoint = rect.origin;
    CGPoint endPoint = rect.origin;
    endPoint.y += rect.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    //上の線
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, rect.size.width, 0); 
    CGContextStrokePath(context);
    
    //下の線
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height); 
    CGContextStrokePath(context);
    
    //三角の位置
    float x = 32;//rect.size.width - 20;
    float y = 15;//12;
    //三角の中身
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4].CGColor);
    CGContextBeginPath(context);
    if(extended){
        CGContextMoveToPoint(context, x+12, y+8);
        CGContextAddLineToPoint(context, x, y+8);
        CGContextAddLineToPoint(context, x+6, y);
    }else{
        CGContextMoveToPoint(context, x, y);
        CGContextAddLineToPoint(context, x+12, y);
        CGContextAddLineToPoint(context, x+6, y+8);
    }
    CGContextClosePath(context);
    CGPathRef path = CGContextCopyPath(context);
    CGContextFillPath(context);
    
    //三角の枠
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3].CGColor);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGPathRelease(path);
    
    //三角内部のテカリ
    CGContextBeginPath(context);
    if(extended){
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3].CGColor);
        CGContextMoveToPoint(context, x, y+8);
        CGContextAddLineToPoint(context, x+12, y+8);
    }else{
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4].CGColor);
        CGContextMoveToPoint(context, x, y);
        CGContextAddLineToPoint(context, x+6, y+8);
    }
    CGContextStrokePath(context);
}

//動的に行を追加するとサイズがおかしくなってしまうので修正。なんでか？
- (void)setNeedsLayout
{
    self.layer.bounds = savedRect;
    self.ctrl.frame = savedRect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
