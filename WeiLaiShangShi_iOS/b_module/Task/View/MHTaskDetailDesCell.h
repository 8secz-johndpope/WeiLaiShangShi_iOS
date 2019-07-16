//
//  MHTaskDetailDesCell.h
//  wgts
//
//  Created by yuhao on 2018/11/8.
//  Copyright © 2018 mhtx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^copyAct)(void);
@interface MHTaskDetailDesCell : UITableViewCell
@property(nonatomic, copy) copyAct CopyAct;
@property(nonatomic, strong) UILabel *deslabel;
@end
