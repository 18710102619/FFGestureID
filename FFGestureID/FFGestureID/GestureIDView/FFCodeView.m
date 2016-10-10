//
//  FFCodeView.m
//  WBTokenCode
//
//  Created by 张玲玉 on 16/1/25.
//  Copyright © 2016年 bj.58.com. All rights reserved.
//

#import "FFCodeView.h"

@implementation FFCodeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGSize size=self.frame.size;
    
    double line_w=1.0,h=size.width-2*line_w;
    CGRect frame1=CGRectMake(line_w, line_w, h, h);
    
    double point_w=size.width/4.0,x=(size.width-point_w)/2.0;
    CGRect frame2=CGRectMake(x, x, point_w, point_w);
    
    if (!_selected) {
        CGContextSetRGBStrokeColor(context, 1, 0.5, 0.3, 1.0);
        CGContextAddEllipseInRect(context,frame1);
        CGContextSetLineWidth(context,line_w);
        CGContextStrokePath(context);
    }
    else {
        if (_success) {
            CGContextSetRGBFillColor(context,30/255.f, 175/255.f, 235/255.f, 0.5);
        }
        else {
            CGContextSetRGBFillColor(context,208/255.f, 36/255.f, 36/255.f, 0.5);
        }
        CGContextAddEllipseInRect(context,frame1);
        CGContextFillPath(context);
        if (_success) {
            CGContextSetRGBStrokeColor(context, 2/255.f, 174/255.f, 240/255.f, 1.0);
            CGContextSetRGBFillColor(context,2/255.f, 174/255.f, 240/255.f, 1.0);
        }
        else {
            CGContextSetRGBStrokeColor(context, 208/255.f, 36/255.f, 36/255.f, 1.0);
            CGContextSetRGBFillColor(context,208/255.f, 36/255.f, 36/255.f, 1.0);
        }
        CGContextAddEllipseInRect(context,frame1);
        CGContextSetLineWidth(context,line_w);
        CGContextStrokePath(context);
        CGContextAddEllipseInRect(context,frame2);
        CGContextFillPath(context);
    }
}

@end
