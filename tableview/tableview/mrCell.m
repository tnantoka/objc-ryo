//
//  mrCell.m
//  tableview
//
//  Created by ryo on 12/06/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "mrCell.h"

@implementation mrCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.textLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height); 
    CGContextStrokePath(context);
}

@end
