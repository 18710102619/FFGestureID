//
//  FFGestureIDView.h
//  WBTokenCode
//
//  Created by 张玲玉 on 16/1/25.
//  Copyright © 2016年 bj.58.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FFGestureIDViewDelegate <NSObject>

//- (void)gestureIDResult:(TCPasswordResult)ret;

@optional

- (void)forgetGestureID;

@end

@interface FFGestureIDView : UIView

@property(nonatomic,assign)id<FFGestureIDViewDelegate> delegate;

@end
