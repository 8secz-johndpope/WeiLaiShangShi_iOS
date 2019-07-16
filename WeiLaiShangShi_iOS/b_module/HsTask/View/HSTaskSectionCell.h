//
//  HSTaskSectionCell.h
//  HSKD
//
//  Created by yuhao on 2019/3/11.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^changetab)(NSInteger index);
@interface HSTaskSectionCell : UITableViewCell
@property(nonatomic,copy)changetab ChangeTab;
-(void)setselecttab:(NSInteger)index;
-(void)setSelectTab:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
