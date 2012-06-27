//
//  ViewController.m
//  tableview
//
//  Created by ryo on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#include <objc/runtime.h>

@interface NSDictionary (mrNSDictionaryExtensionMethods)
@property () BOOL extended;
@end
@implementation NSDictionary (mrNSDictionaryExtensionMethods)
- (BOOL)extended
{
    return [objc_getAssociatedObject(self, @"extended") boolValue];
}
- (void)setExtended:(BOOL)extended
{
    objc_setAssociatedObject(self, @"extended", [NSNumber numberWithLongLong:extended], OBJC_ASSOCIATION_COPY);
}
@end

@implementation ViewController

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id sectionItem = [_items objectAtIndex:indexPath.section];
    NSString *text = [[sectionItem objectForKey:@"items"] objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = (id)[_tableView dequeueReusableCellWithIdentifier:@"hoge"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hoge"] autorelease];
    }
    cell.textLabel.text = text;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *sectionItem = [_items objectAtIndex:section];
    if(sectionItem.extended){
        NSArray *sitems = [sectionItem objectForKey:@"items"];
        return sitems ? sitems.count : 0;
    }else{
        return 0;
    }
}

//セクション数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    id sectionItem = [_items objectAtIndex:section];
    
    UITableViewCell *cell = (id)[_tableView dequeueReusableCellWithIdentifier:@"fuga"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fuga"] autorelease];
        cell.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
        UIControl *ctrl = [[UIControl alloc] initWithFrame:cell.bounds];
        ctrl.backgroundColor = [UIColor clearColor];
        [cell addSubview:ctrl];
        [ctrl release];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [sectionItem objectForKey:@"text"];
    
    UIControl *ctrl = [cell.subviews lastObject];
    ctrl.frame = cell.bounds;
    ctrl.tag = section;
    [ctrl addTarget:self action: @selector(headerTapped:) forControlEvents: UIControlEventTouchUpInside];
    return cell;
}

- (void)headerTapped:(UIControl*)ctrl
{
    NSDictionary *sectionItem = [_items objectAtIndex:ctrl.tag];
    sectionItem.extended = !sectionItem.extended;
    [_tableView reloadData];
}

- (id)init
{
    self = [super init];
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.view = [[[UIView alloc] initWithFrame:frame] autorelease];
    
    _items = [[NSMutableArray alloc] init];
    
    NSArray *ary;
    NSString *text;
    NSDictionary *dict;
    ary = [NSArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e", nil];
    text = @"アルファベット";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    text = @"数字";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"あ",@"い",@"う",@"え",@"お", nil];
    text = @"ひらがな";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"ア",@"イ",@"ウ",@"エ",@"オ", nil];
    text = @"カタカナ";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"Ma",@"Na",@"Ka",@"Na", nil];
    text = @"マナカナ";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    text = @"謎文字";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"😄",@"😍",@"😳",@"😜",@"😱", nil];
    text = @"絵文字";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"Ag",@"Pt",@"Ca",@"Na",@"Mg", nil];
    text = @"記号";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  
    [self.view addSubview:_tableView];
    [_tableView release];
    
    return self;
}

- (void)dealloc
{
    [_items release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
