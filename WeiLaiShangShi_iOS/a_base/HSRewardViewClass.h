//
//  HSRewardViewClass.h
//  HSKD
//
//  Created by yuhao on 2019/2/26.
//  Copyright © 2019 hf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HSCircle;
NS_ASSUME_NONNULL_BEGIN

@interface HSRewardViewClass : NSObject

@property(strong,nonatomic)UIWindow *window;
@property(strong,nonatomic)UIButton *button;
@property(strong,nonatomic)UIView *bgview;
@property(strong,nonatomic)UIImageView *moneyImage;
@property(strong,nonatomic)UIImageView *SmallmoneyImage;
@property(strong,nonatomic)UILabel *moneylabel;
@property(strong,nonatomic)HSCircle *pathView;
@property(strong,nonatomic)NSTimer *timer;
@property(assign,nonatomic)NSInteger time;
@property(assign,nonatomic)CGFloat proess;
/**
 *  获取单例
 */
+ (instancetype)sharedApi;
/**
 *  创建视图
 */
-(void)creteAnmiatedView;
/**
 *  创建计时器
 */
-(void)creteTimeClockWithTimeT:(NSInteger)timer;

@end

NS_ASSUME_NONNULL_END
