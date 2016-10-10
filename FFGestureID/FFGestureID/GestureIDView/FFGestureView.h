//
//  FFGestureView.h
//  WBTokenCode
//
//  Created by 张玲玉 on 16/1/28.
//  Copyright © 2016年 bj.58.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FFGestureViewDelegate <NSObject>

//- (void)handlePasswordResult:()type;

@end

@interface FFGestureView : UIView

@property(nonatomic,assign)id<FFGestureViewDelegate> delegate;
@property(nonatomic,assign)double width;

@end
