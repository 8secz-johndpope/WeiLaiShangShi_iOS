//
//  HSFriendHeadReusableView.h
//  HSKD
//
//  Created by AllenQin on 2019/5/6.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSMoneyTextField.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^imageClick)(void);
typedef void(^exchargeClick)(NSString *money);

@interface HSFriendHeadReusableView : UICollectionReusableView

@property(nonatomic, strong) UIImageView *yaoqing;

@property(nonatomic, copy)imageClick imageClick;

@property(nonatomic, copy)exchargeClick exchargeClick;

@property(strong,nonatomic) UILabel *stateLabel;

@property(strong,nonatomic) UILabel *ylzLabel;

@property(strong,nonatomic) UILabel *allLabel;

@property(strong,nonatomic) UILabel *descLabel;

@property(strong,nonatomic)CSMoneyTextField *tf;


@end

NS_ASSUME_NONNULL_END
