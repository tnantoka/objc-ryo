//
//  mrSectionHeaderCell.h
//  tableview
//
//  Created by ryo on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mrSectionHeaderCell : UITableViewCell
@property (retain, nonatomic) UIControl *ctrl;
@property (assign) BOOL extended;
@property (assign) CGRect savedRect;
@end
