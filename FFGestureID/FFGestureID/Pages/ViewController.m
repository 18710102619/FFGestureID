//
//  ViewController.m
//  FFGestureID
//
//  Created by 张玲玉 on 16/10/10.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import "ViewController.h"
#import "FFGestureView.h"
#import "Masonry.h"

#define kMainScreen_Width [[UIScreen mainScreen] bounds].size.width
#define kMainScreen_Height [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    double gap=50,w=kMainScreen_Width-2*gap;
    double y=64+(kMainScreen_Height-64-w)/2;
    
    FFGestureView *gestureView=[[FFGestureView alloc]init];
    gestureView.width=w;
    gestureView.frame=CGRectMake(gap, y, w, w);
    [self.view addSubview:gestureView];
}

@end
