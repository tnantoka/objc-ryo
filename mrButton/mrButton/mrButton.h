//
//  mrButton.h
//  mrButton
//
//  Created by ryo on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mrButton : UIButton{
    UILabel *_titleLabel;
}
@property(nonatomic,retain) UIColor *tintColor;
@property(nonatomic,retain) NSString *title;
+ (id)buttonWithFrame:(CGRect)frame;
- (UIFont*)font;
- (void)setFont:(UIFont*)font;
@end
