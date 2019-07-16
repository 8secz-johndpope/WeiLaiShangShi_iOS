//
//  HSAriiceShareCell.h
//  HSKD
//
//  Created by yuhao on 2019/4/9.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^shareblock)(void);
typedef void(^Mianze)(void);
@interface HSAriiceShareCell : UITableViewCell
@property(nonatomic, copy)shareblock Share;
@property(nonatomic, copy)Mianze mianze;
@end

NS_ASSUME_NONNULL_END
