//
//  FFGestureView.m
//  WBTokenCode
//
//  Created by 张玲玉 on 16/1/28.
//  Copyright © 2016年 bj.58.com. All rights reserved.
//

#import "FFGestureView.h"
#import "FFCodeView.h"

@interface FFGestureView ()

@property(nonatomic,strong)NSMutableArray *codeArray;
@property(nonatomic,strong)NSMutableArray *selectedCodes;

@property(nonatomic,assign)BOOL success;
@property(nonatomic,copy)NSString *oldPassword;

@end

@implementation FFGestureView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled=YES;
        self.backgroundColor=[UIColor clearColor];
        self.selectedCodes=[NSMutableArray array];
        self.success=YES;
    }
    return self;
}

- (void)setWidth:(double)width
{
    _width=width;
    
    for (int i=0; i<9; i++) {
        int row=i/3,col=i%3;
        double w=_width/4.0,gap=(_width-3*w)/2.0;
        FFCodeView *code=self.codeArray[i];
        code.frame=CGRectMake(col*(w+gap), row*(w+gap), w, w);
    }
}

- (NSMutableArray *)codeArray
{
    if (_codeArray==nil) {
        _codeArray=[NSMutableArray array];
        for (int i=0; i<9; i++) {
            FFCodeView *code=[[FFCodeView alloc]init];
            code.number=i;
            [self addSubview:code];
            [_codeArray addObject:code];
        }
    }
    return _codeArray;
}

#pragma mark - 方法

- (void)disGesture
{
    _success=YES;
    
    [_selectedCodes removeAllObjects];
    [self setNeedsDisplay];
    
    for (FFCodeView *code in _codeArray) {
        code.selected=NO;
        [code setNeedsDisplay];
    }
}

- (BOOL)isSelected:(FFCodeView *)code
{
    for (FFCodeView *item in _selectedCodes) {
        if (item.number==code.number) {
            return YES;
        }
    }
    return NO;
}

- (NSMutableString *)getPassword
{
    NSMutableString *password=[NSMutableString string];
    for (FFCodeView *code in _selectedCodes) {
        [password appendString:[NSString stringWithFormat:@"%tu",code.number]];
    }
    return password;
}

#pragma mark - 手势

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (FFCodeView *code in _codeArray) {
        if (CGRectContainsPoint(code.frame, [[touches anyObject] locationInView:self])) {
            code.selected = YES;
            code.success = YES;
            [_selectedCodes addObject:code];
            [code setNeedsDisplay];
            [self setNeedsDisplay];
            break;
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (FFCodeView *code in _codeArray) {
        if (CGRectContainsPoint(code.frame, [[touches anyObject] locationInView:self])) {
            if ([self isSelected:code]) {
                return;
            }
            code.selected=YES;
            code.success=YES;
            [_selectedCodes addObject:code];
            [code setNeedsDisplay];
            [self setNeedsDisplay];
            break;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (FFCodeView *code in _selectedCodes) {
        code.success=_success;
        [code setNeedsDisplay];
    }
    [self setNeedsDisplay];
}

#pragma mark - 绘制

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5);
    if (_success) {
        CGContextSetRGBStrokeColor(context, 2/255.f, 174/255.f, 240/255.f, 0.7);
    }
    else {
        CGContextSetRGBStrokeColor(context, 208/255.f, 36/255.f, 36/255.f, 0.7);
    }
    for (int i=0; i<_selectedCodes.count; i++) {
        FFCodeView *code=_selectedCodes[i];
        if (i==0) {
            CGContextMoveToPoint(context, code.center.x, code.center.y);
        }
        else {
            CGContextAddLineToPoint(context, code.center.x,code.center.y);
        }
    }
    CGContextStrokePath(context);
}

@end
