//
//  HSCircle.m
//  HSKD
//
//  Created by yuhao on 2019/2/27.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSCircle.h"
@interface HSCircle()

@property(nonatomic,strong)UILabel *label;
@property(nonatomic,assign)CGFloat lineWidth;

@property(nonatomic,strong)CAShapeLayer *foreLayer;//蒙版layer
@end
@implementation HSCircle
-(instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lineWidth = lineWidth;
        
        [self seup:frame];
    }
    return self;
}
-(void)seup:(CGRect) rect{
    
    //背景灰色
    CAShapeLayer *shapeLayer =[[CAShapeLayer alloc]init];
    
    shapeLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.width);
    shapeLayer.lineWidth = _lineWidth;
    
    shapeLayer.fillColor =[UIColor clearColor].CGColor;
    shapeLayer.strokeColor = KColorFromRGB(0xF2F2F2).CGColor;
    
    
    CGPoint center =  CGPointMake((rect.size.width )/2, (rect.size.width)/2);
    
    UIBezierPath *bezierPath =[UIBezierPath bezierPathWithArcCenter:center radius:(rect.size.width- _lineWidth)/2 startAngle:-0.5 *M_PI endAngle:1.5 *M_PI clockwise:YES];
    shapeLayer.path = bezierPath.CGPath;
    
    [self.layer addSublayer:shapeLayer];
    
    
    //渐变色，加蒙版，显示的蒙版的区域
    CAGradientLayer *gradientLayer =[[CAGradientLayer alloc]init];
    
    gradientLayer.frame = self.bounds;
    
    gradientLayer.colors = @[(id)KColorFromRGB(0xDB0E34).CGColor,(id)KColorFromRGB(0xDB0E34).CGColor];
    
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    [self.layer addSublayer:gradientLayer];
    
    
    self.foreLayer = [CAShapeLayer layer];
    self.foreLayer.frame = self.bounds;
    
    self.foreLayer.fillColor =[UIColor clearColor].CGColor;
    
    self.foreLayer.lineWidth = self.lineWidth;
    self.foreLayer.strokeColor = [UIColor redColor].CGColor;
    
    self.foreLayer.strokeEnd = 0;
    self.foreLayer.lineCap = kCALineCapRound;
    
    self.foreLayer.path = bezierPath.CGPath;
    
    gradientLayer.mask = self.foreLayer;
    
    
    self.label =[[UILabel alloc]initWithFrame:self.bounds];
    self.label.text  = @"";
    [self addSubview:self.label];
    
    self.label.font =[UIFont boldSystemFontOfSize:2];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor =[UIColor whiteColor];
}
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    
    self.label.text = [NSString stringWithFormat:@"%.f%%",progress *100];
    self.foreLayer.strokeEnd = _progress;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
