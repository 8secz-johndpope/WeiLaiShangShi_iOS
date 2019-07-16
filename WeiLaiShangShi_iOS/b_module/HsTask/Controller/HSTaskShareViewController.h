//
//  HSTaskShareViewController.h
//  HSKD
//
//  Created by yuhao on 2019/4/11.
//  Copyright © 2019 hf. All rights reserved.
//

#import "MHBaseViewController.h"
@class HSCircle;
NS_ASSUME_NONNULL_BEGIN

@interface HSTaskShareViewController : MHBaseViewController
@property(nonatomic, strong)NSString *taskId;
@property(nonatomic, strong)NSString *taskname;
@property(nonatomic, strong)NSString *comeform;
@property(nonatomic, strong)NSString *vipLever;
@property(nonatomic, strong)NSString *IsVaild;
@property(assign, nonatomic)BOOL IsshowTop;
@property(strong,nonatomic)UIView *bgviewtime;
@property(nonatomic,strong)UILabel *titlelabel;
@property(strong,nonatomic)UILabel *moneylabel;
@property(strong,nonatomic)UIImageView *moneyImage;
@property(strong,nonatomic)UIImageView *SmallmoneyImage;
@property(assign,nonatomic)CGFloat proess;
@property(strong,nonatomic)HSCircle *pathView;
@end

NS_ASSUME_NONNULL_END
