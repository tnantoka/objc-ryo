//
//  ViewController.m
//  tableview
//
//  Created by ryo on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "mrSectionHeaderCell.h"
#include <objc/runtime.h>

// extendedってproperty作っただけ。
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
    objc_setAssociatedObject(self, @"extended", [NSNumber numberWithLongLong:extended], OBJC_ASSOCIATION_ASSIGN);
}
@end



@implementation ViewController

//展開したセル
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id sectionItem = [_items objectAtIndex:indexPath.section];
    NSString *text = [[sectionItem objectForKey:@"items"] objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = (id)[_tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
    }
    cell.textLabel.text = text;
    return cell;
}

//展開したセルの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

//展開したセルの数
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

//セクションヘッダの高さ
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

//セクションヘッダ
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionItem = [_items objectAtIndex:section];
    
    mrSectionHeaderCell *cell = (id)[_tableView dequeueReusableCellWithIdentifier:@"header"];
    if (cell == nil) {
        cell = [[[mrSectionHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"] autorelease];
    }
    cell.textLabel.text = [sectionItem objectForKey:@"text"];
    cell.extended = sectionItem.extended;
    cell.ctrl.tag = section;
    [cell.ctrl addTarget:self action: @selector(headerTapped:) forControlEvents: UIControlEventTouchUpInside];
    return cell;
}

//セクションヘッダをタップした
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
    
    //ファイルから読み込んでソートして、とかやったらいいんだけど面倒なので
    _items = [[NSMutableArray alloc] init];
    NSArray *ary;
    NSString *text;
    NSDictionary *dict;
    ary = [NSArray arrayWithObjects:@"あいず",@"あんこ",@"いのしし",@"えだまめ",@"おじさん", nil];
    text = @"あ";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"かまめし",@"くち",@"くすり",@"こうじ", nil];
    text = @"か";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"さんじょう",@"しりもち",@"しおじい",@"すめし",@"すわ",@"せんべい",@"そうめん", nil];
    text = @"さ";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"たからずか",@"たのしい",@"ちょっと",@"つらい",@"てんぐ",@"とおりこす", nil];
    text = @"た";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"なたね",@"にしん",@"ぬかづけ",@"ねこ",@"のろし", nil];
    text = @"な";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"はじ",@"はんぱ",@"ひんみん",@"ふつう",@"へらす", nil];
    text = @"は";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"まつだいら",@"みつなり",@"むねみつ",@"めんこい",@"もうしぶんない", nil];
    text = @"ま";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"やっこさん", nil];
    text = @"や";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"らいおん",@"りゅう",@"れんこん",@"ろうじん", nil];
    text = @"ら";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"わし",@"わだ", nil];
    text = @"わ";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  
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
