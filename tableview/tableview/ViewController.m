//
//  ViewController.m
//  tableview
//
//  Created by ryo on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "mrSectionHeaderCell.h"
#import "mrCell.h"
#import <QuartzCore/QuartzCore.h>
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
    
    mrCell *cell = (id)[_tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[mrCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
    }
    cell.textLabel.text = text;
    
    return cell;
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

//セクションヘッダ
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    [self sectionIndexColorChange];
    
    NSDictionary *sectionItem = [_items objectAtIndex:section];
    
    mrSectionHeaderCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:@"header"];
    if (cell == nil) {
        cell = [[[mrSectionHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"] autorelease];
    }
    cell.textLabel.text = [sectionItem objectForKey:@"text"];
    cell.extended = sectionItem.extended;
    cell.tag = section;
    cell.ctrl.tag = section;
    [cell.ctrl addTarget:self action: @selector(headerTapped:) forControlEvents: UIControlEventTouchUpInside];
    CGRect rect = cell.bounds;
    rect.size.height = tableView.sectionHeaderHeight;
    cell.savedRect = rect;
    
    return cell;
}

- (void)sectionIndexColorChange
{
    if(!_sectionIndexColorChanged){
        UIColor *indexColor = [UIColor colorWithWhite:0.2 alpha:0.3];
        if ([_tableView respondsToSelector:@selector(setSectionIndexColor:)]){
            _sectionIndexColorChanged = YES;
            [_tableView setSectionIndexColor:indexColor];
        }else{
            for(UIView *view in [_tableView subviews]) {
                if([view respondsToSelector:@selector(setIndexColor:)]) {
                    _sectionIndexColorChanged = YES;
                    [view performSelector:@selector(setIndexColor:) withObject:indexColor];
                }
            }
        }
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *preferredLang = @"ja";//[languages objectAtIndex:0];
    NSString *titles;
    if([preferredLang isEqualToString:@"ja"])
        titles = @"あ/か/さ/た/な/は/ま/や/ら/わ/A/●/D/●/G/●/J/●/M/●/P/●/T/●/Z";
    else
        titles = @"A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z";
    return [titles componentsSeparatedByString: @"/"];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

//セクションヘッダをタップした
- (void)headerTapped:(UIControl*)ctrl
{
    int section = ctrl.tag;
    NSDictionary *sectionItem = [_items objectAtIndex:section];
    sectionItem.extended = !sectionItem.extended;
    
    // not Animation
    //[_tableView reloadData];
    //return;
    
    [_tableView beginUpdates];
    NSArray *sitems = [sectionItem objectForKey:@"items"];
    NSMutableArray *indexes = [[NSMutableArray alloc] initWithCapacity:sitems.count];
    for(int i=0;i<sitems.count;i++){
        [indexes addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    if(sectionItem.extended){
        [_tableView insertRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationFade];
    }else{
        [_tableView deleteRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationFade];
    }
    [indexes release];
    [_tableView endUpdates];
    
    for(mrSectionHeaderCell *cell in _tableView.subviews){
        if([cell isKindOfClass:[mrSectionHeaderCell class]]){
            if(cell.tag==section){
                cell.extended = sectionItem.extended;
                [cell setNeedsDisplay];
                break;
            }
        }
    }
}

- (id)init
{
    self = [super init];
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    self.view = [[[UIView alloc] initWithFrame:frame] autorelease];
    
    //ファイルから読み込んでソートして、とかやったらいいんだけど面倒なので
    _items = [[NSMutableArray alloc] init];
    NSArray *ary;
    NSString *text;
    NSDictionary *dict;
    ary = [NSArray arrayWithObjects:@"あいず",@"あんこ",@"いのしし",@"えだまめ",@"おじさん", nil];
    text = @"あ";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    dict.extended = YES;
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"かまめし",@"くち",@"くすり",@"こうじ", nil];
    text = @"か";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    dict.extended = YES;
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"さんじょう",@"しりもち",@"しおじい",@"すめし",@"すわ",@"せんべい",@"そうめん", nil];
    text = @"さ";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    dict.extended = YES;
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"たからずか",@"たのしい",@"ちょっと",@"つらい",@"てんぐ",@"とおりこす", nil];
    text = @"た";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    dict.extended = YES;
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"なたね",@"にしん",@"ぬかづけ",@"ねこ",@"のろし", nil];
    text = @"な";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    dict.extended = YES;
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"はじ",@"はんぱ",@"ひんみん",@"ふつう",@"へらす", nil];
    text = @"は";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    dict.extended = YES;
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"まつだいら",@"みつなり",@"むねみつ",@"めんこい",@"もうしぶんない", nil];
    text = @"ま";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"やっこさん", nil];
    text = @"や";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    dict.extended = YES;
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"らいおん",@"りゅう",@"れんこん",@"ろうじん", nil];
    text = @"ら";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    dict.extended = YES;
    [_items addObject:dict];
    ary = [NSArray arrayWithObjects:@"わし",@"わだ", nil];
    text = @"わ";
    dict = [NSDictionary dictionaryWithObjectsAndKeys:ary,@"items",text,@"text", nil];
    dict.extended = YES;
    [_items addObject:dict];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 40.0;
    _tableView.sectionHeaderHeight = 30.0;
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
