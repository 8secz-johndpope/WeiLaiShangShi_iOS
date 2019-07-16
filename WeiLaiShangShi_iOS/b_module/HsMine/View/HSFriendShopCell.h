//
//  HSFriendShopCell.h
//  HSKD
//
//  Created by yuhao on 2019/3/5.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HomepageItemEnterDetailBlock)(NSInteger type);
typedef void(^Chongzhi)(void);
typedef void(^imageClick)(void);

@interface HSFriendShopCell : UITableViewCell
@property(copy,nonatomic)HomepageItemEnterDetailBlock block;
@property(nonatomic, strong) NSMutableArray *ActivityArr;
@property(nonatomic, strong) UIButton *qiandaobtn;
@property(nonatomic, copy)Chongzhi chongzhi;
@property(nonatomic, copy)imageClick imageClick;
@property(nonatomic, strong) UIImageView *yaoqing;
@end

NS_ASSUME_NONNULL_END
