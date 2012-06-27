//
//  ViewController.h
//  tableview
//
//  Created by ryo on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_items;
}
@end
