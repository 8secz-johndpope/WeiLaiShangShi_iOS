//
//  HSRewardViewClass.m
//  HSKD
//
//  Created by yuhao on 2019/2/26.
//  Copyright © 2019 hf. All rights reserved.
//

#import "HSRewardViewClass.h"
#import "HSCircle.h"
@implementation HSRewardViewClass
/**
 *  获取单例
 */
+ (instancetype)sharedApi
{
    static HSRewardViewClass *_sharedApi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedApi = [[[self class] alloc] init];
       
    });
    return _sharedApi;
    
}
/**
 *  创建视图
 */
-(void)creteAnmiatedView
{
    self.window = [[UIApplication sharedApplication] keyWindow];
    self.window.backgroundColor = [UIColor clearColor];
    self.bgview = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - kRealValue(100), kRealValue(100), kRealValue(60), kRealValue(60))];
    self.bgview.layer.cornerRadius = kRealValue(30);
    self.bgview.backgroundColor = [UIColor whiteColor];
    [self.window addSubview:self.bgview];
    

    self.pathView =[[HSCircle alloc]initWithFrame:CGRectMake(kRealValue(5), kRealValue(5), self.bgview.frame.size.width - kRealValue(10), self.bgview.frame.size.width - kRealValue(10)) lineWidth:kRealValue(5)];
//    self.pathView.center = self.window.center;
    
    self.pathView.backgroundColor =[UIColor clearColor];
    [self.bgview addSubview:self.pathView];
   
    
    
    self.moneyImage = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kRealValue(30), kRealValue(30))];
    self.moneyImage.image = kGetImage(@"all_gold_animation");
    [self.bgview addSubview:self.moneyImage];
    
    
    self.SmallmoneyImage = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(14), kRealValue(25), kRealValue(13), kRealValue(13))];
    self.SmallmoneyImage.image = kGetImage(@"all_gold_animation");
    self.SmallmoneyImage.hidden = YES;
    [self.bgview addSubview:self.SmallmoneyImage];
    
    
    self.moneylabel = [[UILabel alloc]init];
    self.moneylabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(10)];
    self.moneylabel.textColor = KColorFromRGB(0xDB0E34);
    self.moneylabel.text = @"+10";
    self.moneylabel.hidden = YES;
    [self.bgview addSubview:self.moneylabel];
    [self.moneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.SmallmoneyImage.mas_right).offset(kRealValue(2));
        make.centerY.equalTo(self.SmallmoneyImage.mas_centerY).offset(kRealValue(0));
    }];
    
}
/**
 *  创建计时器
 */
-(void)creteTimeClockWithTimeT:(NSInteger)timer
{
    
    _time = timer;
    if (self.timer) {
            [self.timer invalidate];
        }
    if (!self.timer) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.timer= [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(Timered:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
            [[NSRunLoop currentRunLoop] run];
        });
    }
    
}
- (void)Timered:(NSTimer*)timer {
    NSLog(@"timer called");
    CGFloat singerproess = (CGFloat)1 /self.time/10 ;
    self.proess += singerproess;
    self.pathView.progress = self.proess;
    if (self.proess >= 1.0) {
        [self.timer invalidate];
        //开始奖励动画
        [self startRewardAmited];
    }
}
-(void)startRewardAmited
{
    [UIView transitionWithView:self.moneyImage duration:2 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0 animations:^{
            self.moneyImage.frame = CGRectMake(kRealValue(30), kRealValue(50), 0, 0);
            
            
        } completion:^(BOOL finished) {
            self.SmallmoneyImage.hidden = NO;
            self.moneylabel.hidden = NO;
            [self performSelector:@selector(dismiss) afterDelay:2];
            
        }];
      
        
    }];
}
-(void)dismiss
{
    if (self.bgview) {
         [self.bgview removeFromSuperview];
    }
   
}
@end
