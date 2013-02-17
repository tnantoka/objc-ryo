//
//  ViewController.m
//  meteor
//
//  Created by Miyake Ryo on 13/02/08.
//  Copyright (c) 2013年 Miyake Ryo. All rights reserved.
//

#import "ViewController.h"
#import "ParticleEffectLayerFactory.h"


@interface ViewController (){
    UIImageView *_backView;
    UIControl *_mView;
    
    UISlider *_countSlider;
    UISlider *_speedSlider;
    UISegmentedControl *_typeSC;
    UITextField *_textF;
}

@end

@implementation ViewController

- (void)mainTouch:(id)sender
{
    if([_textF isFirstResponder]){
        [_textF resignFirstResponder];
        return;
    }
    srand(rand()+time(nil));
    float x = _backView.center.x;
    float y = _backView.center.y;

    int count = _countSlider.value;
    double speed = _speedSlider.value;
    //NSString *text = _textF.text;
    ParticleEffectType type = _typeSC.selectedSegmentIndex;
    double delay = 0;
    for(int i=0;i<count;i++){
        int val1 = 0, val2 = 0;
        int g = IPAD ? 90 : 30;
        while (sqrt(pow(val1,2)+pow(val2,2))<g/3) {
            val1 = rand()%g;
            val2 = rand()%g;
        }
        switch (rand()%4) {
            case 1:
                val1 *= -1;
                break;
            case 2:
                val1 *= -1;
                val2 *= -1;
                break;
            case 3:
                val2 *= -1;
                break;
        }
        int d = IPAD ? 10 : 12;
        CGPoint	location = {x+val1, y+val2};
        CGPoint	from = {x+(val1*d), y+(val2*d)};
        NSDictionary *info = @{
                               @"location":[NSValue valueWithCGPoint:location],
                               @"from":[NSValue valueWithCGPoint:from],
                               @"type":[NSNumber numberWithInt:type],
                               @"speed":[NSNumber numberWithDouble:speed],
                               @"index":[NSNumber numberWithInt:i],
                               //@"text":text,
                               };
        [self performSelector:@selector(makeParticle:) withObject:info afterDelay:delay];
        delay += 0.1*speed;
    }}

-(void)makeParticle:(NSDictionary*)info
{
    id __weak __self = self;
    UIView __weak *__mView = _mView;
    ParticleEffectType type = [[info objectForKey:@"type"] intValue];
    ParticleEffectLayer *elayer = [ParticleEffectLayerFactory createParticleEffectLayerFromType:type];
    elayer.location = [[info objectForKey:@"location"] CGPointValue];
    [self.view.layer addSublayer:elayer];
    double speed = [[info objectForKey:@"speed"] doubleValue];
    elayer.time *= speed;
    elayer.tag = [[info objectForKey:@"index"] intValue];
    switch (type) {
        case peRock:
        {
            [(id)elayer setTo:elayer.location];
            elayer.location = [[info objectForKey:@"from"] CGPointValue];
            [elayer go];
            break;
        }
        case peMeteor:
        {
            [(id)elayer setTo:elayer.location];
            elayer.location = [[info objectForKey:@"from"] CGPointValue];
            [elayer goAndComplete:^(ParticleEffectLayer*layer){
                BomEffectLayer *elayer = [BomEffectLayer layer];
                elayer.location = layer.position;
                elayer.time *= speed;
                [__mView.layer addSublayer:elayer];
                [elayer goAndComplete:^(ParticleEffectLayer*layer){
                    [__self fadeOutGoblin];
                }];
            }];
            break;
        }
        case peKita:
        {
            NSString *text = [info objectForKey:@"text"];
            if(text && [text length]>0)
                [(id)elayer setText:text];
            [elayer go];
            break;
        }
        case peDodo:
        case peRasen:
        {
            NSString *text = [info objectForKey:@"text"];
            if(text && [text length]>0)
                [(id)elayer setText:text];
            [(id)elayer setCenter:_backView.center];
            [elayer go];
            break;
        }
        case peTitle:
        {
            [elayer goAndComplete:^(ParticleEffectLayer*layer){
                [NSThread sleepForTimeInterval:3];
            }];
            break;
        }
        default:
            [elayer go];
            break;
    }
}

- (void)fadeOutGoblin
{
    if(_backView.layer.opacity > 0 && !_backView.hidden){
        CABasicAnimation *anime = [CABasicAnimation animationWithKeyPath:@"opacity"];
        anime.fromValue = @0.8;
        anime.toValue = @0;
        anime.duration = 1;
        [_backView.layer addAnimation:anime forKey:@"opacity"];
        _backView.layer.opacity = 0;
    }
}

- (void)goblin
{
    _backView.hidden = !_backView.hidden && _backView.layer.opacity!=0;
    _backView.layer.opacity = 1;
}

- (void)yah
{
    NSString *text = _textF.text;
    if(![text length])
        return;
    id __weak _w_self = self;
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
	[accountStore requestAccessToAccountsWithType:accountType
                                          options:nil
                                       completion:^(BOOL granted, NSError *error) {
                                           if(!granted)
                                               return;
                                           ACAccount *twaccount = [[accountStore accountsWithAccountType:accountType] lastObject];
                                           NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
                                           NSDictionary *param = @{@"q":text,@"count":@"100"};
                                           SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                                   requestMethod:SLRequestMethodGET
                                                                                             URL:url
                                                                                      parameters:param];
                                           request.account = twaccount;
                                           [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                               if (!error) {
                                                   [_w_self performSelectorOnMainThread:@selector(yahyah:)
                                                                             withObject:responseData
                                                                          waitUntilDone:NO];
                                               }else{
                                                   LOG2(@"%@",error);
                                               }
                                           }];
                            }];
}

- (void)yahyah:(NSData*)data
{
    [data writeToFile:[NSString stringWithFormat:@"%@/hoge.data", NSHomeDirectory()] atomically:NO];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //LOG(@"%@",json);
    if([json isKindOfClass:[NSDictionary class]]){
        NSArray *statuses = [json objectForKey:@"statuses"];
        
        double delay = 0;
        double speed = _speedSlider.value * 3.4;
        for(id status in [statuses reverseObjectEnumerator]){
            
            id _status = [status objectForKey:@"retweeted_status"];
            if(!_status)
                _status = status;
            NSString *text = [self removeAt:[_status objectForKey:@"text"]];
            //LOG(@"%@",[_status objectForKey:@"text"]);
            NSDictionary *info = @{
                                   @"text":text,
                                   @"location":[NSValue valueWithCGPoint:CGPointZero],
                                   @"type":[NSNumber numberWithInt:peKita],
                                   @"speed":[NSNumber numberWithDouble:speed],
                                   @"index":[NSNumber numberWithInt:0],
                                   };
            [self performSelector:@selector(makeParticle:) withObject:info afterDelay:delay];
            delay += 0.3*speed;
        }
    }
}

- (void)yoh
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)oops
{
    NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/hoge.data", NSHomeDirectory()]
                                          options:0 error:nil];
    [self yahyah:data];
}

- (void)gue
{
    NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/fuga.data", NSHomeDirectory()]
                                          options:0 error:nil];
    [self yahyah:data];
}

- (void)gul
{
    NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/hoge.data", NSHomeDirectory()]
                                          options:0 error:nil];
    [self gulgul:data];
}

- (void)titlecall
{
    NSDictionary *info = @{
                           @"location":[NSValue valueWithCGPoint:_backView.center],
                           @"type":[NSNumber numberWithInt:peTitle],
                           @"speed":[NSNumber numberWithDouble:2],
                           @"index":[NSNumber numberWithInt:0],
                           };
    [self performSelector:@selector(makeParticle:) withObject:info afterDelay:0];
}
- (void)gulgul:(NSData*)data
{
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if([json isKindOfClass:[NSDictionary class]]){
        NSArray *statuses = [json objectForKey:@"statuses"];
        
        double delay = 0;
        double speed = _speedSlider.value*2;
        for(id status in [statuses reverseObjectEnumerator]){
            
            id _status = [status objectForKey:@"retweeted_status"];
            if(!_status)
                _status = status;
            NSString *text = [self removeAt:[_status objectForKey:@"text"]];
            NSDictionary *info = @{
                                   @"text":text,
                                   @"location":[NSValue valueWithCGPoint:CGPointZero],
                                   @"type":[NSNumber numberWithInt:peRasen],
                                   @"speed":[NSNumber numberWithDouble:speed],
                                   @"index":[NSNumber numberWithInt:0],
                                   };
            [self performSelector:@selector(makeParticle:) withObject:info afterDelay:delay];
            delay += 0.2*speed;
        }
    }
}

- (void)motto
{
    _countSlider.maximumValue = 60;
    _countSlider.value = 60;
    float v = _speedSlider.value;
    _speedSlider.value = v*2;
    [self mainTouch:nil];
    _countSlider.maximumValue = 20;
    _speedSlider.value = v;
}

- (void)countSet:(UIBarButtonItem*)item
{
    _countSlider.value = item.tag;
}

- (void)speedSet:(UIBarButtonItem*)item
{
    _speedSlider.value = item.tag;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CGRect frame = self.view.bounds;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    CGRect mainRect = frame;
    mainRect.size.height -= 88;
    _mView = [[UIControl alloc] initWithFrame:mainRect];
    [_mView addTarget:self action:@selector(mainTouch:) forControlEvents:UIControlEventTouchUpInside];
    _mView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_mView];
    
    _backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"goblin.png"]];
    _backView.frame = IPAD ? CGRectMake(0,0,300,300) : CGRectMake(0,0,120,120);
    _backView.hidden = YES;
    _backView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
    [self.view insertSubview:_backView belowSubview:_mView];
    _backView.center = _mView.center;
    
    CGRect toolbarRect = frame;
    toolbarRect.size.height = 44;
    toolbarRect.origin.y += frame.size.height - toolbarRect.size.height;
    
    UIToolbar *toolbar3 = [[UIToolbar alloc] initWithFrame:toolbarRect];
    toolbar3.barStyle = UIBarStyleBlackOpaque;
    toolbar3.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:toolbar3];
    
    toolbarRect.origin.y -= toolbarRect.size.height;
    
    UIToolbar *toolbar2 = [[UIToolbar alloc] initWithFrame:toolbarRect];
    toolbar2.barStyle = UIBarStyleBlackOpaque;
    toolbar2.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:toolbar2];
    
    toolbarRect.origin.y -= toolbarRect.size.height;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:toolbarRect];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:toolbar];
    
    toolbarRect.origin.y -= toolbarRect.size.height;
    
    UIToolbar *toolbar4 = [[UIToolbar alloc] initWithFrame:toolbarRect];
    toolbar4.barStyle = UIBarStyleBlackOpaque;
    toolbar4.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:toolbar4];

    
    
    NSMutableArray *items = [NSMutableArray array];
    UIBarButtonItem *item;
    
    item = [[UIBarButtonItem alloc] initWithTitle:@"1個" style:UIBarButtonItemStylePlain
                                           target:self action:@selector(countSet:)];
    item.tag = 1;
    [items addObject:item];
    
    _countSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 205, 10)];
    _countSlider.minimumValue = 1;
    _countSlider.maximumValue = 20;
    _countSlider.value = 20;
    item = [[UIBarButtonItem alloc] initWithCustomView:_countSlider];
    [items addObject:item];
    
    item = [[UIBarButtonItem alloc] initWithTitle:@"20個" style:UIBarButtonItemStylePlain
                                           target:self action:@selector(countSet:)];
    item.tag = 20;
    [items addObject:item];
    
    item = [[UIBarButtonItem alloc] initWithTitle:@"もっと" style:UIBarButtonItemStyleBordered
                                           target:self action:@selector(motto)];
    [items addObject:item];
    
    [toolbar setItems:items];
    
    //toolbar2
    items = [NSMutableArray array];
    
    item = [[UIBarButtonItem alloc] initWithTitle:@"普通" style:UIBarButtonItemStylePlain
                                           target:self action:@selector(speedSet:)];
    item.tag = 1;
    [items addObject:item];
    
    _speedSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 10)];
    _speedSlider.minimumValue = 1;
    _speedSlider.maximumValue = 5;
    _speedSlider.value = 1;
    item = [[UIBarButtonItem alloc] initWithCustomView:_speedSlider];
    [items addObject:item];
    
    item = [[UIBarButtonItem alloc] initWithTitle:@"遅い" style:UIBarButtonItemStylePlain
                                           target:self action:@selector(speedSet:)];
    item.tag = 5;
    [items addObject:item];
    
    [toolbar2 setItems:items];
    
    //toolbar3
    items = [NSMutableArray array];
    
    _typeSC = [[UISegmentedControl alloc] initWithItems:@[@"爆発", @"隕石", @"メテオ", @"回復", @"キ", @"ド", @"羅"]];
    _typeSC.selectedSegmentIndex = 2;
    _typeSC.segmentedControlStyle = UISegmentedControlStyleBar;
    item = [[UIBarButtonItem alloc] initWithCustomView:_typeSC];
    [items addObject:item];
    item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [items addObject:item];
    item = [[UIBarButtonItem alloc] initWithTitle:@"ゴブリン" style:UIBarButtonItemStyleBordered
                                           target:self action:@selector(goblin)];
    [items addObject:item];
    [toolbar3 setItems:items];
    
    //toolbar4
    items = [NSMutableArray array];
    
    _textF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    _textF.borderStyle = UITextBorderStyleRoundedRect;
    _textF.backgroundColor = [UIColor grayColor];
    _textF.text = @"俺";
    item = [[UIBarButtonItem alloc] initWithCustomView:_textF];
    [items addObject:item];
    item = [[UIBarButtonItem alloc] initWithTitle:@"ヤー！" style:UIBarButtonItemStyleBordered
                                           target:self action:@selector(yah)];
    [items addObject:item];
    item = [[UIBarButtonItem alloc] initWithTitle:@"とめ" style:UIBarButtonItemStyleBordered
                                           target:self action:@selector(yoh)];
    [items addObject:item];
    item = [[UIBarButtonItem alloc] initWithTitle:@"リ" style:UIBarButtonItemStyleBordered
                                           target:self action:@selector(oops)];
    [items addObject:item];
    item = [[UIBarButtonItem alloc] initWithTitle:@"ゲッ" style:UIBarButtonItemStyleBordered
                                           target:self action:@selector(gue)];
    [items addObject:item];
    item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [items addObject:item];
    
    item = [[UIBarButtonItem alloc] initWithTitle:@"タイトル" style:UIBarButtonItemStyleBordered
                                           target:self action:@selector(titlecall)];
    [items addObject:item];

    item = [[UIBarButtonItem alloc] initWithTitle:@"ぐるん" style:UIBarButtonItemStyleBordered
                                           target:self action:@selector(gul)];
    [items addObject:item];
    
    [toolbar4 setItems:items];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

static NSRegularExpression *regexp = nil;
- (NSString*)removeAt:(NSString*)str
{
    if(regexp==nil){
        regexp = [NSRegularExpression regularExpressionWithPattern:@"@([0-9a-zA-Z_-]{1,15})"
                                                           options:0
                                                             error:nil];
    }
    if(regexp){
        NSString *replaced =
        [regexp stringByReplacingMatchesInString:str
                                         options:0
                                           range:NSMakeRange(0,[str length])
                                    withTemplate:@""];
        return replaced;
    }
    
    return str;
}

@end
