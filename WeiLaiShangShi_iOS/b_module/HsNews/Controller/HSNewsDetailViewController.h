//
//  HSNewsDetailViewController.h
//  HSKD
//
//  Created by yuhao on 2019/3/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHBaseViewController.h"
@class HSCircle;
NS_ASSUME_NONNULL_BEGIN

@interface HSNewsDetailViewController : MHBaseViewController
@property(nonatomic, strong)NSString *ariticeID;
@property(nonatomic, strong)NSString *IsAd;
@property(nonatomic, strong)UILabel *showTimeLabel;
@property(nonatomic, strong)UIImageView *bgview;
@property(strong,nonatomic)UIWindow *window;
@property(strong,nonatomic)UIView *bgviewtime;
@property(strong,nonatomic)HSCircle *pathView;
@property(assign, nonatomic)BOOL IsshowTop;
@property(strong,nonatomic)UILabel *moneylabel;
@property(strong,nonatomic)UIImageView *moneyImage;
@property(strong,nonatomic)UIImageView *SmallmoneyImage;
@property(assign,nonatomic)CGFloat proess;
@end

NS_ASSUME_NONNULL_END
