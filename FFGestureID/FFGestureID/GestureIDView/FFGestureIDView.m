//
//  FFGestureIDView.h
//  WBTokenCode
//
//  Created by 张玲玉 on 16/1/25.
//  Copyright © 2016年 bj.58.com. All rights reserved.
//

#import "FFGestureIDView.h"
#import "FFGestureView.h"
#import "AppDelegate.h"

#define kGap 50
#define kCount 5

@interface FFGestureIDView ()<FFGestureViewDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *manageBtn;
@property(nonatomic,strong)FFGestureView *gestureView;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)int count;
@property(nonatomic,assign)int min;

@end

@implementation FFGestureIDView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.count=5;
        
        
        double width=frame.size.width-2*kGap;
        double space=(frame.size.height-width)/2.0;
        
        _label=[[UILabel alloc]init];
        _label.font=[UIFont systemFontOfSize:12];
        _label.text=@"请绘制解锁图案";
        _label.textColor=[UIColor grayColor];
        _label.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_label];
        [_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(30));
            make.left.right.equalTo(@(0));
            make.top.equalTo(@(space/2.0));
        }];
        
        _gestureView=[[TCGestureView alloc]init];
        _gestureView.delegate=self;
        _gestureView.width=width;
        _gestureView.passwordHandle=_passwordHandle;
        [self addSubview:_gestureView];
        [_gestureView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(_gestureView.width, _gestureView.width));
            make.center.equalTo(self);
        }];
        
        if ([_passwordVM isExist]) {
            _manageBtn=[UIButton buttonWithType:UIButtonTypeSystem];
            _manageBtn.titleLabel.font=kFont_Size_Nom;
            [_manageBtn setTitle:@"密码管理" forState:UIControlStateNormal];
            [_manageBtn setTitleColor:kColor_Theme forState:UIControlStateNormal];
            [_manageBtn addTarget:self action:@selector(addActionSheet) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_manageBtn];
            [_manageBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(200, 50));
                make.bottom.equalTo(@(-20));
                make.centerX.equalTo(self);
            }];
        }
        
        NSDate *date=[[NSUserDefaults standardUserDefaults]objectForKey:kFreezeTime];
        _min=[date timeIntervalSinceNow]/60;
        if (_min>0) {
            [self startTiming];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

- (void)addActionSheet
{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"修改手势密码", @"忘记手势密码",@"切换其他账号", nil];
    [actionSheet showInView:self.gestureView];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            _passwordHandle=UPDATE_PASSWORD;
            _label.text=@"请输入原手势密码";
            _label.textColor=[UIColor grayColor];
        }
            break;
        case 1:
        {
            [self.delegate forgetGestureID];
        }
            break;
        case 2:
        {
            [[TCAuth sharedAuth]removeAuthURL];
            [kAppDelegate setActionController];
        }
        default:
            break;
    }
}

#pragma mark - TCGestureViewDelegate

- (void)startTiming
{
    _label.text=[NSString stringWithFormat:@"请%i分钟后重试",_min];;
    _gestureView.userInteractionEnabled=NO;
    _manageBtn.userInteractionEnabled=NO;
    if (_timer==nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(timing) userInfo:nil repeats:YES];
    }
    _label.textColor=[UIColor redColor];
}

- (void)timing
{
    if (_min>0) {
        _label.text = [NSString stringWithFormat:@"请%i分钟后重试",--_min];
    }
    else {
        [self stopTiming];
    }
}

- (void)stopTiming
{
    _label.text=@"请绘制解锁图案";
    _label.textColor=[UIColor grayColor];
    _gestureView.userInteractionEnabled=YES;
    _manageBtn.userInteractionEnabled=YES;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    if (_min>0) {
        NSDate *date=[[NSDate alloc]initWithTimeIntervalSinceNow:_min*60];
        [[NSUserDefaults standardUserDefaults]setObject:date forKey:kFreezeTime];
    }
}

@end
